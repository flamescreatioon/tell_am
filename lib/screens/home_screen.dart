import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tell_am/components/bottom_navbar.dart';
import 'package:tell_am/screens/food_detail.dart';
import 'package:tell_am/models/cart_manager.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key?key}):super(key:key);

  @override
  HomeScreenState createState()=>HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{
  final TextEditingController _searchController = TextEditingController();
  int _currentBannerIndex = 0;
  final PageController _bannerController = PageController();
  Timer? _bannerTimer;

  final List<Map<String, dynamic>> _banners = [
    {
      'image': 'assets/images/Afang soup.jpg',
      'title': 'Enjoy 20% Off',
      'subtitle': 'On your first order',
    },
    {
      'image': 'assets/images/Akara and Pap.jpg',
      'title': 'Free Delivery',
      'subtitle': 'On orders above ₦5000',
    },
    {
      'image': 'assets/images/Amala and Ewedu.jpg',
      'title': 'Special Offers',
      'subtitle': 'Limited time deals',
    },
  ];
  final List<Map<String, dynamic>> _categories = [
    {
      'icon': Icons.restaurant,
      'name': 'All',
      'id': 0,
    },
    {
      'icon': Icons.local_dining,
      'name': 'Local Dishes',
      'id': 1,
    },
    {
      'icon': Icons.fastfood,
      'name': 'Fast Food',
      'id': 2,
    },
    {
      'icon': Icons.local_drink,
      'name': 'Drinks',
      'id': 3,
    },
    {
      'icon': Icons.cake,
      'name': 'Desserts',
      'id': 4,
    },
    {
      'icon': Icons.breakfast_dining,
      'name': 'Breakfast',
      'id': 5,
    },
  ];
  final List<Map<String, dynamic>> _featuredItems = [
    {
      'image': 'assets/images/Jollof rice and Plantain.jpg',
      'name': 'Jollof Rice & Chicken',
      'restaurant': 'Mama\'s Kitchen',
      'rating': 4.8,
      'price': 2500,
      'currency': '₦',
      'prepTime' : 20,
      'isFavorite': true,
      'description': 'Enjoy true Nigerian Jollof at Mama\'s Kitchen'
    },
    {
      'image': 'assets/images/Egusi Soup.jpg',
      'name': 'Egusi Soup & Pounded Yam',
      'restaurant': 'Traditional Tastes',
      'rating': 4.6,
      'price': 3200,
      'currency': '₦',
      'isFavorite': false,
      'prepTime' : 20,
      'description': 'Enjoy delicious Egusi soup and nice pounded yam at Traditional Tastes'
    },
    {
      'image': 'assets/images/Pancakes.jpg',
      'name': 'Suya Platter',
      'restaurant': 'Northern Delights',
      'rating': 4.7,
      'price': 2800,
      'currency': '₦',
      'isFavorite': true,
      'prepTime' : 20,
      'description': 'Enjoy true Nigerian Jollof at Mama\'s Kitchen'
    },
    {
      'image': 'assets/images/jollof rice and Plantain.jpg',
      'name': 'Plantain & Fish Pepper Soup',
      'restaurant': 'Coastal Flavors',
      'rating': 4.5,
      'price': 3000,
      'currency': '₦',
      'isFavorite': false,
      'prepTime' : 20,
      'description': 'Enjoy true Nigerian Jollof at Mama\'s Kitchen'
    },
  ];

  final List<Map<String, dynamic>> _popularBukas = [
    {
      'image': 'assets/images/Beans Porridge.jpg',
      'name': 'Mama\'s Kitchen',
      'rating': 4.8,
      'deliveryTime': '25-35',
      'distance': 1.2,
    },
    {
      'image': 'assets/images/Vegetable soup and Fufu.jpg',
      'name': 'Traditional Tastes',
      'rating': 4.6,
      'deliveryTime': '30-40',
      'distance': 2.1,
    },
    {
      'image': 'assets/images/Pancakes.jpg',
      'name': 'Northern Delights',
      'rating': 4.7,
      'deliveryTime': '20-30',
      'distance': 0.8,
    },
  ];

@override
  void initState() {
    super.initState();
    _startBannerTimer();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentBannerIndex < _banners.length - 1) {
        _currentBannerIndex++;
      } else {
        _currentBannerIndex = 0;
      }
      
      if (_bannerController.hasClients) {
        _bannerController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _navigateToSearch(String query) {
    // Navigate to search results
    if (query.trim().isNotEmpty) {
      // Navigator.pushNamed(context, '/search', arguments: {'query': query});
    }
  }

  void _navigateToCategory(int categoryId) {
    Navigator.pushNamed(
      context, 
      '/menu', 
      arguments: {'categoryId': categoryId},
    );
  }

  void _navigateToBuka(Map<String, dynamic> buka) {
    // Navigate to restaurant/buka detail
    // Navigator.pushNamed(context, '/buka-detail', arguments: {'bukaId': buka['id']});
  }

  void _navigateToFoodDetail(Map<String, dynamic> food) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailScreen(food: food),
      ),
    );
  }

  void _toggleFavorite(int index) {
    setState(() {
      _featuredItems[index]['isFavorite'] = !_featuredItems[index]['isFavorite'];
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _featuredItems[index]['isFavorite'] 
              ? 'Added to favorites' 
              : 'Removed from favorites'
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _addToCart(Map<String, dynamic> food) {
    // Add item to cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${food['name']} added to cart'),
        action: SnackBarAction(
          label: 'VIEW CART',
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }


@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: const Text('Home'),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: (){
            
          },
        ),

        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: (){

          },
        )
      ],
    ),

    body: SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
        }, child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for food, restaurants...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: (){

                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(vertical: 0)
                  ),
                  ),
                ),
              
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _bannerController,
                  onPageChanged: (index){
                    setState(() {
                      _currentBannerIndex = index;
                    });
                  },
                  itemCount: _banners.length,
                  itemBuilder: (context, index){
                    return _buildBanner(_banners[index]);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _banners.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentBannerIndex == index ? Colors.orange: Colors.orange.withOpacity(0.3),
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextButton(
                      onPressed: (){

                      },
                      child: const Text(
                        'See all',
                        style: TextStyle(
                          color: Colors.orange,
                        ),

                      ),
                    )

                  ],
                )
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: _categories.length,
                  itemBuilder: (context, index){
                    return _buildCategoryItem(_categories[index]);

                  }

                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Featured Items',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                    
                      ),
                    ),
                  TextButton(
                    onPressed: (){

                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  )
                  ],
                  ),
              ),

               SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _featuredItems.length,
                    itemBuilder: (context, index) {
                      return _buildFeaturedItem(_featuredItems[index], index);
                    },
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular Bukas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to all restaurants
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _popularBukas.length,
                  itemBuilder: (context, index) {
                    return _buildBukaItem(_popularBukas[index]);
                  },
                ),
                const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.orange),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.orange),
                ),
                const SizedBox(height: 10),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'johndoe@example.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home_outlined, 'Home', () {
            Navigator.pop(context);
          }),
          _buildDrawerItem(Icons.person_outline, 'My Profile', () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/profile');
          }),
          _buildDrawerItem(Icons.restaurant_menu_outlined, 'All Menus', () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/menu');
          }),
          _buildDrawerItem(Icons.receipt_long_outlined, 'My Orders', () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/orders-history');
          }),
          _buildDrawerItem(Icons.favorite_border_outlined, 'Favorites', () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/favorites');
          }),
          _buildDrawerItem(Icons.location_on_outlined, 'Delivery Addresses', () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/addresses');
          }),
          _buildDrawerItem(Icons.payment_outlined, 'Payment Methods', () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/payment-methods');
          }),
          const Divider(),
          _buildDrawerItem(Icons.settings_outlined, 'Settings', () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/settings');
          }),
          _buildDrawerItem(Icons.help_outline, 'Help & Support', () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/support');
          }),
          _buildDrawerItem(Icons.exit_to_app, 'Logout', () {
            Navigator.pop(context);
            // Show logout confirmation
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('LOGOUT'),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildBanner(Map<String, dynamic> banner) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.orange,
          image: DecorationImage(
            image: AssetImage(banner['image']),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
            onError: (error, stackTrace) {
              // Image error handling
            },
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                banner['title'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                banner['subtitle'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  // Navigate to promotion details
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text('Order Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () => _navigateToCategory(category['id']),
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                category['icon'],
                color: Colors.orange,
                size: 30,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category['name'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedItem(Map<String, dynamic> food, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetailScreen(food: food),
          ),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.symmetric(horizontal: 8),
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
            // Food Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    food['image'],
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 140,
                        color: Colors.grey[300],
                        child: const Icon(Icons.restaurant, size: 40, color: Colors.grey),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _toggleFavorite(index),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        food['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                        color: food['isFavorite'] ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Food Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    food['restaurant'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        food['rating'].toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${food['currency']}${food['price']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _addToCart(food),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
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

  Widget _buildBukaItem(Map<String, dynamic> buka) {
    return GestureDetector(
      onTap: () => _navigateToBuka(buka),
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
        child: Row(
          children: [
            // Restaurant Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: Image.asset(
                buka['image'],
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.restaurant, size: 40, color: Colors.grey),
                  );
                },
              ),
            ),
            
            // Restaurant Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buka['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          buka['rating'].toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.grey[600], size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${buka['deliveryTime']} min',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${buka['distance']} km',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // View Button
            Padding(
              padding: const EdgeInsets.all(12),
              child: IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.orange),
                onPressed: () => _navigateToBuka(buka),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
