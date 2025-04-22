import 'package:flutter/material.dart';
import 'dart:async';

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
      'image': 'assets/images/banner1.jpg',
      'title': 'Enjoy 20% Off',
      'subtitle': 'On your first order',
    },
    {
      'image': 'assets/images/banner2.jpg',
      'title': 'Free Delivery',
      'subtitle': 'On orders above ₦5000',
    },
    {
      'image': 'assets/images/banner3.jpg',
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
      'image': 'assets/images/food1.jpg',
      'name': 'Jollof Rice & Chicken',
      'restaurant': 'Mama\'s Kitchen',
      'rating': 4.8,
      'price': 2500,
      'currency': '₦',
      'isFavorite': true,
    },
    {
      'image': 'assets/images/food2.jpg',
      'name': 'Egusi Soup & Pounded Yam',
      'restaurant': 'Traditional Tastes',
      'rating': 4.6,
      'price': 3200,
      'currency': '₦',
      'isFavorite': false,
    },
    {
      'image': 'assets/images/food3.jpg',
      'name': 'Suya Platter',
      'restaurant': 'Northern Delights',
      'rating': 4.7,
      'price': 2800,
      'currency': '₦',
      'isFavorite': true,
    },
    {
      'image': 'assets/images/food4.jpg',
      'name': 'Plantain & Fish Pepper Soup',
      'restaurant': 'Coastal Flavors',
      'rating': 4.5,
      'price': 3000,
      'currency': '₦',
      'isFavorite': false,
    },
  ];

  final List<Map<String, dynamic>> _popularBukas = [
    {
      'image': 'assets/images/restaurant1.jpg',
      'name': 'Mama\'s Kitchen',
      'rating': 4.8,
      'deliveryTime': '25-35',
      'distance': 1.2,
    },
    {
      'image': 'assets/images/restaurant2.jpg',
      'name': 'Traditional Tastes',
      'rating': 4.6,
      'deliveryTime': '30-40',
      'distance': 2.1,
    },
    {
      'image': 'assets/images/restaurant3.jpg',
      'name': 'Northern Delights',
      'rating': 4.7,
      'deliveryTime': '20-30',
      'distance': 0.8,
    },
  ];

  @override
  void initState(){
    super.initState();
    _startBannerTimer();
  }

  @override
  void dispose(){
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
    }
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

    body
  );
}
}

