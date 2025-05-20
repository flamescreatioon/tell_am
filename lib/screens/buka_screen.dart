import 'package:flutter/material.dart';
import 'package:tell_am/components/bottom_navbar.dart';

class BukaScreen extends StatefulWidget {
  // Renamed class
  const BukaScreen({Key? key}) : super(key: key);

  @override
  BukaScreenState createState() => BukaScreenState(); // Renamed state
}

class BukaScreenState extends State<BukaScreen> {
  // Renamed state class
  final TextEditingController _searchController = TextEditingController();

  // Sample vendor data - Replace with your actual data source
  final List<Map<String, dynamic>> _vendors = [
    {
      'image': 'assets/images/Beans Porridge.jpg',
      'name': "Mama's Kitchen",
      'rating': 4.8,
      'deliveryTime': '25-35',
      'distance': 1.2,
      'categories': ['Local Dishes', 'Soups', 'Rice'],
      'isOpen': true,
      'minimumOrder': 2000,
      'deliveryFee': 500,
    },
    {
      'image': 'assets/images/Vegetable soup and Fufu.jpg',
      'name': 'Traditional Tastes',
      'rating': 4.6,
      'deliveryTime': '30-40',
      'distance': 2.1,
      'categories': ['Swallow', 'Soups', 'Local Dishes'],
      'isOpen': true,
      'minimumOrder': 1500,
      'deliveryFee': 600,
    },
    {
      'image': 'assets/images/Pancakes.jpg',
      'name': 'Northern Delights',
      'rating': 4.7,
      'deliveryTime': '20-30',
      'distance': 0.8,
      'categories': ['Breakfast', 'Local Dishes'],
      'isOpen': false,
      'minimumOrder': 1800,
      'deliveryFee': 400,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToVendorDetail(Map<String, dynamic> vendor) {
    // Navigate to vendor detail screen
    // Navigator.pushNamed(context, '/vendor-detail', arguments: vendor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Bukas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search vendors...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      // Show filter options
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            // Vendor List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _vendors.length,
                itemBuilder: (context, index) {
                  return _buildVendorCard(_vendors[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }

  Widget _buildVendorCard(Map<String, dynamic> vendor) {
    return GestureDetector(
      onTap: () => _navigateToVendorDetail(vendor),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vendor Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.asset(
                    vendor['image'],
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.restaurant,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: vendor['isOpen'] ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      vendor['isOpen'] ? 'Open' : 'Closed',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Vendor Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          vendor['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            vendor['rating'].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Categories
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (vendor['categories'] as List<String>)
                        .map((category) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                category,
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 12,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),

                  // Delivery Info
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${vendor['deliveryTime']} min',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${vendor['distance']} km',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Order Info
                  Row(
                    children: [
                      Text(
                        'Min. Order: ₦${vendor['minimumOrder']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Delivery: ₦${vendor['deliveryFee']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
