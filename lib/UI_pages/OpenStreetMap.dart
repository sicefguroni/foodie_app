import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../Utilities/utilities_buttons.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../Utilities/color_palette.dart';
import 'package:http/http.dart' as http;

class OpenstreetmapScreen extends StatefulWidget {
  const OpenstreetmapScreen({super.key});

  @override
  State<OpenstreetmapScreen> createState() => _OpenstreetmapScreenState();
}

class _OpenstreetmapScreenState extends State<OpenstreetmapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _locationController = TextEditingController();
  LatLng? _currentLocation;
  LatLng? _destination;
  List<LatLng> _route = [];
  
  // Platform detection
  bool get _isDesktop => !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
  bool get _isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  
  // Mock locations for testing on desktop
  final List<LatLng> _mockLocations = [
    LatLng(10.3157, 123.8854), // Cebu City, Philippines
  ];
  int _currentMockLocationIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    print('=== Initializing location ===');
    print('Platform: ${_getPlatformName()}');
    
    if (_isDesktop) {
      _initializeDesktopLocation();
    } else if (_isMobile) {
      await _initializeMobileLocation();
    } else if (kIsWeb) {
      await _initializeWebLocation();
    }
  }

  String _getPlatformName() {
    if (kIsWeb) return 'Web';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isLinux) return 'Linux';
    if (Platform.isMacOS) return 'macOS';
    return 'Unknown';
  }

  // Desktop platform (Windows/Linux/macOS) - use mock location
  void _initializeDesktopLocation() {
    print('🖥️ Desktop platform detected - using mock location');
    setState(() {
      _currentLocation = _mockLocations[_currentMockLocationIndex];
    });
    print('✅ Mock location set: $_currentLocation');
    
    // Move map to mock location
    _mapController.move(_currentLocation!, 15);
    
    // Show info to user
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDesktopLocationInfo();
    });
  }

  void _showDesktopLocationInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Desktop mode: Using mock location (${_currentLocation!.latitude.toStringAsFixed(4)}, ${_currentLocation!.longitude.toStringAsFixed(4)})'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Change',
          onPressed: _cycleMockLocation,
        ),
      ),
    );
  }

  void _cycleMockLocation() {
    setState(() {
      _currentMockLocationIndex = (_currentMockLocationIndex + 1) % _mockLocations.length;
      _currentLocation = _mockLocations[_currentMockLocationIndex];
    });
    _mapController.move(_currentLocation!, 15);
    print('🔄 Changed to mock location: $_currentLocation');
    
    // Clear route when location changes
    setState(() {
      _route = [];
    });
  }

  // Mobile platform (Android/iOS) - use real GPS
  Future<void> _initializeMobileLocation() async {
    print('📱 Mobile platform detected - using real GPS');
    
    if(!await _checkLocationPermission()) {
      print('❌ Location permission denied');
      return;
    }
    
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      );
      
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
      
      print('✅ Real GPS location set: $_currentLocation');
      _mapController.move(_currentLocation!, 15);
      
    } catch (e) {
      print('❌ Error getting GPS location: $e');
      errorMessage('Failed to get GPS location. Using fallback location.');
      
      // Fallback to mock location if GPS fails
      setState(() {
        _currentLocation = _mockLocations[0]; // Manila as fallback
      });
      _mapController.move(_currentLocation!, 15);
    }
  }

  // Web platform - use browser geolocation
  Future<void> _initializeWebLocation() async {
    print('🌐 Web platform detected - using browser geolocation');
    
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      );
      
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
      
      print('✅ Browser location set: $_currentLocation');
      _mapController.move(_currentLocation!, 15);
      
    } catch (e) {
      print('❌ Browser location failed: $e');
      errorMessage('Browser location denied. Using default location.');
      
      // Fallback to mock location
      setState(() {
        _currentLocation = _mockLocations[0];
      });
      _mapController.move(_currentLocation!, 15);
    }
  }

  Future<bool> _checkLocationPermission() async {
    if (_isDesktop) {
      return true; // Desktop doesn't need permissions for mock location
    }
    
    print('🔐 Checking location permissions...');
    
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('❌ Location services disabled');
        errorMessage('Location services are disabled. Please enable GPS.');
        return false;
      }
      print('✅ Location services enabled');

      LocationPermission permission = await Geolocator.checkPermission();
      print('Current permission: $permission');
      
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        print('Permission after request: $permission');
        
        if (permission == LocationPermission.denied) {
          print('❌ Location permission denied');
          errorMessage('Location permissions are denied');
          return false;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        print('❌ Location permission denied forever');
        errorMessage('Location permissions are permanently denied. Please enable in settings.');
        return false;
      }

      print('✅ Location permission granted');
      return true;
    } catch (e) {
      print('❌ Error checking permissions: $e');
      return false;
    }
  }

  Future<void> _userCurrentLocation() async {
    print('🎯 User requested current location');
    
    if (_isDesktop) {
      // On desktop, cycle through mock locations
      _cycleMockLocation();
      return;
    }
    
    if (_currentLocation != null) {
      print('Using existing location: $_currentLocation');
      _mapController.move(_currentLocation!, 15);
      return;
    }
    
    // Try to get location again
    await _initializeLocation();
  }

  // Your existing methods remain the same
  Future<void> _fetchCoordinatesPoints(String location) async {
    final encodedLocation = Uri.encodeComponent(location);
    final url = Uri.parse("https://nominatim.openstreetmap.org/search?q=$encodedLocation&format=json&limit=1");
    
    print('Fetching coordinates for: $location');
    print('URL: $url');
    
    try {
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'FlutterMapApp/1.0',
        },
      );
      
      print('Response status: ${response.statusCode}');
      
      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        if(data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          print('Found coordinates: $lat, $lon');
          setState(() {
            _destination = LatLng(lat, lon);
            _route = []; // Clear previous route
          });
          await fetchRoute();
        } else {
          print('No results found for: $location');
          errorMessage('Location not found. Please try another search.');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        errorMessage('Failed to fetch location. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in _fetchCoordinatesPoints: $e');
      errorMessage('Error fetching location: $e');
    }
  }

  Future<void> fetchRoute() async {
    if(_currentLocation == null || _destination == null) {
      print('Missing locations - Current: $_currentLocation, Destination: $_destination');
      errorMessage('Current location or destination not available');
      return;
    }
    
    final url = Uri.parse("https://router.project-osrm.org/route/v1/driving/"
    '${_currentLocation!.longitude},${_currentLocation!.latitude};'
    '${_destination!.longitude},${_destination!.latitude}?overview=full&geometries=polyline'
    );

    print('Fetching route from: $_currentLocation to: $_destination');

    try {
      final response = await http.get(url);
      print('OSRM Response status: ${response.statusCode}');
      
      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if(data['routes'] != null && data['routes'].isNotEmpty) {
          final geometry = data['routes'][0]['geometry'];
          _decodePolyLine(geometry);
          print('✅ Route decoded successfully');
        } else {
          errorMessage('No route found');
        }
      } else {
        print('OSRM HTTP Error: ${response.statusCode}');
        errorMessage('Failed to fetch route. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in fetchRoute: $e');
      errorMessage('Error fetching route: $e');
    }
  }

  void _decodePolyLine(String encodedPolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPoints = polylinePoints.decodePolyline(encodedPolyline);

    setState(() {
      _route = decodedPoints
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();
    });
  }

  void errorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation ?? LatLng(14.5995, 120.9842),
              initialZoom: _currentLocation != null ? 15 : 2,
              minZoom: 0,
              maxZoom: 18,
            ),
            children: [
              TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
              
              // Show current location marker
              if(_currentLocation != null)
                MarkerLayer(markers: [
                  Marker(
                    point: _currentLocation!,
                    width: 50,
                    height: 50,
                    child: Icon(
                        Icons.location_pin,
                        color: c_pri_yellow,
                        size: 40,
                    ),
                  ),
                ]),
              
              // Show destination marker
              if(_destination != null)
                MarkerLayer(markers: [
                  Marker(
                    point: _destination!, 
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.location_pin, 
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ]),
              
              // Show route
              if(_currentLocation != null && _destination != null && _route.isNotEmpty)
                PolylineLayer(polylines: [
                  Polyline(
                    points: _route, 
                    strokeWidth: 5,
                    color: Colors.blue,
                  )
                ]),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(8), 
                child: Row(
                  children: [
                    YellowBackButton(),
                  ],
                ),
              ),
            ),
          ),
          // Search bar
          Positioned(
            top: 48,
            right: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(8), 
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your destination',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: 
                            EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ) 
                    ),
                    IconButton(
                      onPressed: () {
                        final location = _locationController.text.trim();
                        if(location.isNotEmpty) {
                          _fetchCoordinatesPoints(location);
                        }
                      }, 
                      icon: Icon(Icons.search),
                    )
                  ],
                ),
              ),
            ),
          ),
          
          // Platform indicator
          Positioned(
            bottom: 120,
            left: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_getPlatformName()}${_isDesktop ? ' (Mock GPS)' : ''}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          Positioned(
            bottom: 72,
            right: 8,
            child: Container(
              child: TextButton.icon(
                onPressed: 
                  _userCurrentLocation,
               
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: c_white
                ),
                icon: Icon(Icons.my_location, size: 16),
                label: Text('Use current location', style: TextStyle(fontSize: 12)),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 8,
            right: 8,
            child: Container(
              child: ActionButton(
                buttonName: 'Use Address', 
                backgroundColor: c_pri_yellow, 
                onPressed: () {
                  // Navigator.pop(context);
                }),
            ),
          ),
        ],
      ),
    );
  }
}