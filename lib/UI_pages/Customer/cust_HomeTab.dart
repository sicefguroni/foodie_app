import 'package:flutter/material.dart';
import 'cust_Cart.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_cards.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_others.dart';
import '../../Utilities/utilities_texts.dart';
import 'cust_ProfilePage.dart';
import 'package:foodie_app/UI_pages/Schemas/Food.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Make sure to import your Food model
// import 'path_to_your_food_model/food.dart';

class CustomerHomeTab extends StatefulWidget {
  @override
  State<CustomerHomeTab> createState() => _CustomerHomeTabState();
}

class _CustomerHomeTabState extends State<CustomerHomeTab> {
  final TextEditingController _searchController = TextEditingController();
  List<Food> _searchResults = [];
  List<Food> _allFoods = [];
  bool _isSearching = false;
  bool _isLoading = true;
  RealtimeChannel? _channel;

  @override
  void initState() {
    super.initState();
    fetchFoods();
    setupRealtimeListener();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _channel?.unsubscribe();
    super.dispose();
  }

  Future<void> fetchFoods() async {
    try {
      final response = await Supabase.instance.client
        .from('products')
        .select('*')
        .order('product_name', ascending: true);

      print('Supabase response: $response');

      setState(() {
        _allFoods = response.map<Food>((json) => Food.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching food: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void setupRealtimeListener() {
    _channel = Supabase.instance.client
      .channel('public:products')
      .onPostgresChanges(
        event: PostgresChangeEvent.all, 
        schema: 'public',
        table: 'products',
        callback: (payload) {
          fetchFoods();
          // If currently searching, update search results too
          if (_isSearching && _searchController.text.isNotEmpty) {
            _performSearch(_searchController.text);
          }
        })
      .subscribe();
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _isSearching = false;
        _searchResults.clear();
      } else {
        _isSearching = true;
        _searchResults = _allFoods.where((food) {
          // Adjust these field names based on your Food model structure
          return food.product_name.toLowerCase().contains(query.toLowerCase()) ||
                 (food.category?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
                 (food.description?.toLowerCase().contains(query.toLowerCase()) ?? false);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _isSearching = false;
      _searchResults.clear();
    });
  }

  Widget _buildSearchResults() {
    if (!_isSearching) return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: _searchResults.isEmpty
          ? Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'No items found',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final food = _searchResults[index];
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: c_pri_yellow.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: food.imageUrl != null && food.imageUrl!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              food.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.fastfood, color: c_pri_yellow),
                            ),
                          )
                        : Icon(Icons.fastfood, color: c_pri_yellow),
                  ),
                  title: Text(
                    food.product_name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    '${food.category ?? 'Food'} • \$${food.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  trailing: Text(
                    food.availability ? 'Available' : 'Out of Stock',
                    style: TextStyle(
                      color: food.availability ? Colors.green : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    // Handle item selection
                    _clearSearch();
                    // Navigate to item details or add to cart
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selected: ${food.product_name}')),
                    );
                  },
                );
              },
            ),
    );
  }

  Widget _buildCustomSearchBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _performSearch,
        decoration: InputDecoration(
          hintText: 'Search for food...',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
          suffixIcon: _isSearching
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[500]),
                  onPressed: _clearSearch,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: c_pri_yellow,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16), 
                  bottomRight: Radius.circular(16)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleSectionButton(
                    leftmost: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: c_white,
                      onPressed: () {
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => CustomerCartPage())
                        );
                      },
                    ),
                    right: IconButton(onPressed: () {}, icon: Icon(Icons.notifications), color: c_white),
                    rightmost: ProfileButton(iconColor: c_white, 
                      onPressed: () {
                        return CustomerProfilePage();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Heading3_Text(text: 'What foodie', color: c_white),
                        Heading3_Text(text: 'would you like?', color: c_white),
                      ],
                    ),
                  ),
                  _buildCustomSearchBar(),
                ],
              ),
            ),
            
            // Loading indicator
            if (_isLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: c_pri_yellow),
                ),
              )
            else ...[
              // Search results overlay
              _buildSearchResults(),
              
              // Only show category and picks when not searching
              if (!_isSearching) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 0, 4),
                  child: Text('Category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                // Horizontal scrolling cards with fixed height
                Container(
                  height: 80,
                  child: FoodCategoryCards(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 0, 4),
                  child: Text('Picks for you', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                // Vertical scrolling grid that takes remaining space
                Expanded(
                  child: CustomerFoodCards(),
                ),
              ] else ...[
                // When searching, give search results more space
                SizedBox(height: 16),
              ],
            ],
          ],
        ),
      ),
    );
  }
}