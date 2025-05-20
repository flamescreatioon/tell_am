import 'package:flutter/foundation.dart';

class CartManager {
  // Singleton pattern
  static final CartManager _instance = CartManager._internal();
  
  factory CartManager() {
    return _instance;
  }
  
  CartManager._internal();
  
  // Cart items list
  final List<Map<String, dynamic>> _cartItems = [];
  
  // Getter for cart items
  List<Map<String, dynamic>> get cartItems => _cartItems;
  
  // Add item to cart
  void addToCart(Map<String, dynamic> item) {
    // Check if item already exists in cart
    final existingItemIndex = _cartItems.indexWhere((element) => element['id'] == item['id']);
    
    if (existingItemIndex != -1) {
      // Update quantity if item already exists
      _cartItems[existingItemIndex]['quantity'] += item['quantity'];
    } else {
      // Add new item to cart
      _cartItems.add(item);
    }
  }
  
  // Remove item from cart
  void removeFromCart(String itemId) {
    _cartItems.removeWhere((element) => element['id'] == itemId);
  }
  
  // Update item quantity
  void updateQuantity(String itemId, int quantity) {
    final index = _cartItems.indexWhere((element) => element['id'] == itemId);
    if (index != -1) {
      _cartItems[index]['quantity'] = quantity;
    }
  }
  
  // Clear cart
  void clearCart() {
    _cartItems.clear();
  }
}