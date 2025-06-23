import 'package:flutter/material.dart';
import 'package:tell_am/components/bottom_navbar.dart';

class BukaDetailsScreen extends StatefulWidget {
  final String bukaId;

  const BukaDetailsScreen({
    super.key,
    required this.bukaId,
  });

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
  };

  final List<Map<String, dynamic>> _menuCategories = [
    {'name': 'Popular', 'id': 'popular'},
    {'name': 'Local Dishes', 'id': 'local'},
    {'name': 'Soups', 'id': 'soups'},
    {'name': 'Swallow', 'id': 'swallow'},
    {'name': 'Rice', 'id': 'rice'},
    {'name': 'Drinks', 'id': 'drinks'},
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
