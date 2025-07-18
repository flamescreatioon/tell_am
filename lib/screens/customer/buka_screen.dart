import 'package:flutter/material.dart';
import 'package:tell_am/components/bottom_navbar.dart';

<<<<<<< HEAD:lib/screens/buka_screen.dart
class BukaDetailsScreen extends StatefulWidget {
  final String bukaId;

  const BukaDetailsScreen({
    super.key,
    required this.bukaId,
  });
=======
class BukaScreen extends StatefulWidget {
  // Renamed class
  const BukaScreen({super.key});
>>>>>>> 820007614d27b2a0434e3013afe3e4e724cf6f7d:lib/screens/customer/buka_screen.dart

  @override
  BukaDetailsScreenState createState() => BukaDetailsScreenState();
}

class BukaDetailsScreenState extends State<BukaDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isFavorite = false;
  bool _isLoading = true;
  Map<String, dynamic>? _bukaData;

  final Map<String, Map<String, dynamic>> _bukasData = {
    'buka1': {
      'id': 'buka1',
      'name': "Mama's Kitchen",
      'image': 'assets/images/Beans Porridge.jpg',
      'rating': 4.8,
      'deliveryTime': '25-35',
      'distance': 1.2,
      'isOpen': true,
    },
    'buka2': {
      'id': 'buka2',
      'name': 'Traditional Tastes',
      'image': 'assets/images/Vegetable soup and Fufu.jpg',
      'rating': 4.6,
      'deliveryTime': '30-40',
      'distance': 2.1,
      'isOpen': true,
    },
    'buka3': {
      'id': 'buka3',
      'name': 'Northern Delights',
      'image': 'assets/images/Pancakes.jpg',
      'rating': 4.7,
      'deliveryTime': '20-30',
      'distance': 0.8,
      'isOpen': false,
    },
<<<<<<< HEAD:lib/screens/buka_screen.dart
  };

  final List<Map<String, dynamic>> _menuCategories = [
    {'name': 'Popular', 'id': 'popular'},
    {'name': 'Local Dishes', 'id': 'local'},
    {'name': 'Soups', 'id': 'soups'},
    {'name': 'Swallow', 'id': 'swallow'},
    {'name': 'Rice', 'id': 'rice'},
    {'name': 'Drinks', 'id': 'drinks'},
=======
    {
      'image': 'assets/images/Beans Porridge.jpg',
      'name': 'Mama Nkechi',
      'rating': 4.5,
      'deliveryTime': '15-25',
      'distance': 1.5,
      'categories': ['Beans', 'Local Dishes'],
      'isOpen': true,
      'minimumOrder': 1000,
      'deliveryFee': 300,
    },
    {
      'image': 'assets/images/Salad.jpg',
      'name': 'Healthy Eats',
      'rating': 4.9,
      'deliveryTime': '25-35',
      'distance': 1.2,
      'categories': ['Salads', 'Healthy Meals'],
      'isOpen': true,
      'minimumOrder': 2500,
      'deliveryFee': 800,
    },
    {
      'image': 'assets/images/Cake.jpg',
      'name': 'Sweet Treats',
      'rating': 4.4,
      'deliveryTime': '35-45',
      'distance': 2.5,
      'categories': ['Desserts', 'Cakes'],
      'isOpen': false,
      'minimumOrder': 3000,
      'deliveryFee': 900,
    },
    {
      'image': 'assets/images/Pancakes.jpg',
      'name': "Betty's Breakfast",
      'rating': 4.2,
      'deliveryTime': '20-30',
      'distance': 1.5,
      'categories': ['Pancakes', 'Breakfast', 'Light Meal'],
      'isOpen': true,
      'minimumOrder': 1200,
      'deliveryFee': 700,
    },
>>>>>>> 820007614d27b2a0434e3013afe3e4e724cf6f7d:lib/screens/customer/buka_screen.dart
  ];

  final Map<String, List<Map<String, dynamic>>> _bukaMenuItems = {
    'buka1': [
      {
        'id': 'item1',
        'name': 'Jollof Rice & Chicken',
        'description': 'Spicy rice cooked in tomato sauce with grilled chicken',
        'price': 2500,
        'image': 'assets/images/Jollof Rice.jpg',
        'category': 'rice',
        'isPopular': true,
        'rating': 4.8,
        'numReviews': 245,
      },
      {
        'id': 'item2',
        'name': 'Egusi Soup & Pounded Yam',
        'description': 'Ground melon seeds cooked with vegetables and meat',
        'price': 3000,
        'image': 'assets/images/Egusi soup.jpg',
        'category': 'soups',
        'isPopular': true,
        'rating': 4.7,
        'numReviews': 189,
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _menuCategories.length, vsync: this);
    _loadBukaData();
  }

  Future<void> _loadBukaData() async {
    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 1));
      final bukaData = _bukasData[widget.bukaId];
      if (bukaData == null) throw Exception('Buka not found');
      setState(() {
        _bukaData = bukaData;
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
      _showError('Failed to load buka details');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
        ),
      );
    }
    if (_bukaData == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        ),
        body: const Center(child: Text('Buka not found')),
      );
    }

    final filteredMenuItems = (_bukaMenuItems[widget.bukaId] ?? []).where((item) {
      final query = _searchController.text.toLowerCase();
      return item['name'].toLowerCase().contains(query);
    }).toList();

    return Scaffold(
<<<<<<< HEAD:lib/screens/buka_screen.dart
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _bukaData!['image'],
=======
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
              color: Colors.grey.withValues(alpha: 0.2),
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
>>>>>>> 820007614d27b2a0434e3013afe3e4e724cf6f7d:lib/screens/customer/buka_screen.dart
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.restaurant, size: 50, color: Colors.grey),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: _isFavorite ? Colors.red : Colors.white),
                onPressed: () => setState(() => _isFavorite = !_isFavorite),
              ),
              IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
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
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text(_bukaData!['rating'].toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 16),
                                Text('${_bukaData!['deliveryTime']} min', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                                const SizedBox(width: 16),
                                Text('${_bukaData!['distance']} km', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _bukaData!['isOpen'] ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(_bukaData!['isOpen'] ? 'Open' : 'Closed', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
<<<<<<< HEAD:lib/screens/buka_screen.dart
                  const SizedBox(height: 16),
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search menu items...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
=======
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
                                color: Colors.orange.withValues(alpha: 0.1),
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
>>>>>>> 820007614d27b2a0434e3013afe3e4e724cf6f7d:lib/screens/customer/buka_screen.dart
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.orange,
                tabs: _menuCategories.map((c) => Tab(text: c['name'])).toList(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildMenuItem(filteredMenuItems[index]),
                childCount: filteredMenuItems.length,
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
          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.asset(
              item['image'],
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 120,
                height: 120,
                color: Colors.grey[300],
                child: const Icon(Icons.restaurant, size: 40, color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(item['description'], style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text('₦${item['price']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('${item['rating']} (${item['numReviews']} reviews)', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => Container(color: Colors.white, child: _tabBar);
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
