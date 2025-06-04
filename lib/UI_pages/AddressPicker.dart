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

class AddressPicker extends StatefulWidget {
  const AddressPicker({super.key});

  @override
  State<AddressPicker> createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  final MapController _mapController = MapController();
  final TextEditingController _locationController = TextEditingController();
  LatLng? _selectedLocation;
  String? _selectedAddress;
  
  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchCoordinatesPoints(String location) async {
    final encodedLocation = Uri.encodeComponent(location);
    final url = Uri.parse("https://nominatim.openstreetmap.org/search?q=$encodedLocation&format=json&limit=1");
    
    try {
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'FlutterMapApp/1.0',
        },
      );
      
      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        if(data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          final displayName = data[0]['display_name'];
          
          setState(() {
            _selectedLocation = LatLng(lat, lon);
            _selectedAddress = displayName;
          });
          _mapController.move(_selectedLocation!, 15);
        } 
      } 
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching location: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(10.3225, 123.8986),
              initialZoom: 15,
              minZoom: 0,
              maxZoom: 18,
            ),
            children: [
              TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
              
              // Show selected location marker
              if(_selectedLocation != null)
                MarkerLayer(markers: [
                  Marker(
                    point: _selectedLocation!,
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
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
          Positioned(
            bottom: 16,
            left: 8,
            right: 8,
            child: Container(
              child: ActionButton(
                buttonName: 'Use Address', 
                backgroundColor: c_pri_yellow, 
                onPressed: () {
                  if (_selectedAddress != null) {
                    print("Returning address: $_selectedAddress");
                    Navigator.pop(context, _selectedAddress);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select an address first')),
                    );
                  }
                }),
            ),
          ),
        ],
      ),
    );
  }
}