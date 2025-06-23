import 'package:flutter/material.dart';

class Newscreen extends StatelessWidget {
  final int _selectedIndex = 0; // Example index, replace with your logic
  const Newscreen({super.key});

  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeScreen(context),
        ],
      )),
    );
  }

  Widget _buildHomeScreen(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            _buildHeader(),
            const SizedBox(height: 10),
            _buildHeroSection(),
            const SizedBox(height: 10),
            _buildCategorySection(),
            const SizedBox(height: 10),
            _buildTrendingSection(context),
          ]
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              'User Name',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),

        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          ),
          child: Center(
            child: Icon(
              Icons.notifications_none_rounded,
              color: Colors.grey[600],
              size: 22,
            ),
          ),
        ),
        
      ],
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 180,
      width: 380,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepOrange,
            Colors.orangeAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                height: 100,
                width: 100,
                color: Color(0x20FFFFFF),
              ),
            ),
          ),

          Padding(padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Discover New \nPlaces',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.w800, 
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Explore Now',
                  style: TextStyle(
                    fontSize: 14, 
                    fontWeight: FontWeight.w600, 
                    color: Color(0xFF81A1C1),
                  ),
                ),
              )
            ],
          ),)
        ],
      ),
    );
  }
  
  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Categories'),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildCategoryCard(
                'Food',
                Icons.fastfood,
                Colors.orangeAccent,
              ),
              const SizedBox(width: 16),
              _buildCategoryCard(
                'Drinks',
                Icons.local_drink,
                Colors.deepOrangeAccent,
              ),
              const SizedBox(width: 16),
              _buildCategoryCard(
                'Desserts',
                Icons.cake,
                Colors.pinkAccent,
              ),
              const SizedBox(width: 16),
              _buildCategoryCard(
                'Snacks',
                Icons.local_pizza,
                Colors.greenAccent,
              ),
                  
            ],
          ),
        ),
        
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.w600, 
            color: Colors.black,  
          ),
        ),
        Text(
          'See All',
            style: TextStyle(
              fontSize: 14, 
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      width: 80,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color, 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 22,
            ),

          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14, 
              fontWeight: FontWeight.w600, 
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2),
          Text(
            '${(10 * title.length * 2)} items',
            style: TextStyle(
              fontSize: 12, 
              fontWeight: FontWeight.w400, 
              color: Colors.white70,
            ),
          )
        ],
      ),
    );

  }

  Widget _buildTrendingSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            onTap: (selectedTabIndex) {
            isScrollable: true;
            },
            indicatorColor: Colors.deepOrange,
            labelColor: Colors.black,
            tabs: [
              Tab(child: Text('Trending')),
              Tab(child: Text('Popular')),
              Tab(child: Text('New')),
            ],
          ),
          Container(
            height: 300, // Fixed height for the scrollable section
            child: TabBarView(
              children: [
                //First tab content
                ListView.builder(
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text('Trending Item $index'),
                      subtitle: Text('Description for Item $index'),
                      leading: Icon(Icons.star, color: Colors.red,),
                      trailing: Icon(Icons.arrow_forward),
                    );
                  },
                ),
                // Second tab content
                _buildProductCategory(),
                // Third tab content
                _buildProductCategory(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCategory() {
    // List of products
    final products = [
      {
        'title': 'Pizza Margherita',
        'price': '\$10.99',
        'color': Colors.green,
        'icon':Icons.local_pizza,
      },
      {
        'title': 'Caesar Salad',
        'price': '\$8.99',
        'color': Colors.blue,
        'icon':Icons.restaurant_menu,
      },
      {
        'title': 'Grilled Salmon',
        'price': '\$15.99',
        'color': Colors.orange,
        'icon':Icons.restaurant,
      },
    ];

    return Container(
      height: 300, // Fixed height for the scrollable section
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildProductCard(
              products[index]['title'] as String,
              products[index]['price'] as String,
              products[index]['color'] as Color,
              products[index]['icon'] as IconData,
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(
    String title, String price, Color color, IconData icon) {
    return Container(
      height: 120,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 120,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.w600, 
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 14, 
                      fontWeight: FontWeight.w500, 
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}