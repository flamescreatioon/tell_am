import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bukaName),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
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
