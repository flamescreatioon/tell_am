import 'package:flutter/material.dart';
<<<<<<< HEAD:lib/screens/buka_details_screen.dart

import '../widget/FoodItemCard Widget.dart';

class BukaDetailsScreen extends StatefulWidget {
  final String bukaName;
  final String bukaImage;

  const BukaDetailsScreen({
    Key? key,
    required this.bukaName,
    required this.bukaImage,
  }) : super(key: key);

  @override
  _BukaDetailsScreenState createState() => _BukaDetailsScreenState();
}

class _BukaDetailsScreenState extends State<BukaDetailsScreen> with SingleTickerProviderStateMixin {
=======
import 'package:google_fonts/google_fonts.dart';
import 'package:tell_am/components/bottom_navbar.dart';

class BukaDashboard extends StatefulWidget {
  final String bukaId;

  const BukaDashboard({
    super.key,
    required this.bukaId,
  });

  @override
  BukaDashboardState createState() => BukaDashboardState();
}

class BukaDashboardState extends State<BukaDashboard>
    with SingleTickerProviderStateMixin {
>>>>>>> 820007614d27b2a0434e3013afe3e4e724cf6f7d:lib/screens/buka_owner/buka_dashboard.dart
  late TabController _tabController;

  final List<String> categories = ['All', 'Rice', 'Swallow', 'Soup', 'Drinks'];
  final List<Map<String, String>> bukaItems = [
    {
      'name': 'Jollof Rice',
      'price': '₦1500',
      'image': 'assets/images/rice.jpg',
    },
    {
      'name': 'Eba and Egusi',
      'price': '₦2000',
      'image': 'assets/images/eba_egusi.jpg',
    },
    {
      'name': 'Fufu and Afang',
      'price': '₦1800',
      'image': 'assets/images/fufu_afang.jpg',
    },
    {
      'name': 'Bottled Water',
      'price': '₦200',
      'image': 'assets/images/water.jpg',
    },
<<<<<<< HEAD:lib/screens/buka_details_screen.dart
=======
    'buka4': {
      'id': 'buka4',
      'name': 'Mama Nkechi',
      'image': 'assets/images/Bean Porridge.jpg',
      'rating': 4.5,
      'deliveryTime': '15-25',
      'distance': 1.5,
      'isOpen': true,
    },
    'buka5': {
      'id': 'buka5',
      'name': 'Healthy Eats',
      'image': 'assets/images/Salad.jpg',
      'rating': 4.9,
      'deliveryTime': '25-35',
      'distance': 1.2,
      'isOpen': true,
    },
    'buka6': {
      'id': 'buka6',
      'name': 'Sweet Treats',
      'image': 'assets/images/Cake.jpg',
      'rating': 4.4,
      'deliveryTime': '35-45',
      'distance': 2.5,
      'isOpen': false,
    },
    'buka7': {
      'id': 'buka7',
      'name': "Betty's Breakfast",
      'image': 'assets/images/Pancakes.jpg',
      'rating': 4.2,
      'deliveryTime': '20-30',
      'distance': 1.5,
      'isOpen': true,
    }
  };

  final List<Map<String, dynamic>> _menuCategories = [
    {'name': 'Popular', 'id': 'popular'},
    {'name': 'Local Dishes', 'id': 'local'},
    {'name': 'Soups', 'id': 'soups'},
    {'name': 'Swallow', 'id': 'swallow'},
    {'name': 'Rice', 'id': 'rice'},
    {'name': 'Drinks', 'id': 'drinks'},
>>>>>>> 820007614d27b2a0434e3013afe3e4e724cf6f7d:lib/screens/buka_owner/buka_dashboard.dart
  ];

  @override
  void initState() {
    _tabController = TabController(length: categories.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD:lib/screens/buka_details_screen.dart
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bukaName),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
=======
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        ),
      );
    }

    if (_bukaData == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: Text('Buka not found'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Buka Header with Image
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _bukaData!['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.restaurant,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                onPressed: () {
                  // Implement share functionality
                },
              ),
            ],
          ),

          // Buka Info Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _bukaData!['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  _bukaData!['rating'].toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  '${_bukaData!['deliveryTime']} min',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  '${_bukaData!['distance']} km',
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              _bukaData!['isOpen'] ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _bukaData!['isOpen'] ? 'Open' : 'Closed',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search menu items...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Menu Categories Tabs
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                labelStyle: GoogleFonts.quicksand(),
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.orange,
                tabs: _menuCategories
                    .map((category) => Tab(text: category['name']))
                    .toList(),
              ),
            ),
          ),

          // Menu Items
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final menuItems = _bukaMenuItems[widget.bukaId] ?? [];
                  if (index >= menuItems.length) return null;
                  return _buildMenuItem(menuItems[index]);
                },
                childCount: _bukaMenuItems[widget.bukaId]?.length ?? 0,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
>>>>>>> 820007614d27b2a0434e3013afe3e4e724cf6f7d:lib/screens/buka_owner/buka_dashboard.dart
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(widget.bukaImage, height: 200, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Available Meals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.deepOrange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.deepOrange,
            tabs: categories.map((c) => Tab(text: c)).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: categories.map((category) {
                // Filter logic can go here later
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: bukaItems.length,
                  itemBuilder: (context, index) {
                    final item = bukaItems[index];
                    return FoodItemCard(
                      name: item['name']!,
                      price: item['price']!,
                      imagePath: item['image']!,
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
