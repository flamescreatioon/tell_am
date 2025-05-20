import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const Cart({super.key, required this.cartItems});

  @override
  State<Cart> createState() => CartState();
}

class CartState extends State<Cart> {
  bool isEditing = false;

  double get subtotal {
    return widget.cartItems
        .fold(0, (sum, item) => sum + item['price'] * item['quantity']);
  }

  final double deliveryFee = 1000;

  double get total => subtotal + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          TextButton(
            child: Text(
              isEditing ? 'Done' : 'Edit',
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: widget.cartItems.isEmpty
          ? buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return buildOrderSummary(item);
                    },
                  ),
                ),
                _buildOrderSummary(),
                _buildCheckoutButton(), // Add the checkout button here
              ],
            ),
    );
  }

  Widget buildEmptyCart() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shopping_cart_outlined,
          size: 100,
          color: Colors.grey[500],
        ),
        const SizedBox(height: 20),
        Text('Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            )),
        const SizedBox(height: 10),
        Text('Add items to get started',
            style: TextStyle(fontSize: 16, color: Colors.grey)),
        const SizedBox(height: 30),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Browse Menu',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ))
      ],
    ));
  }

  // Remove or comment out this method as it's not being used correctly
  // Widget buildCartItems(Map<String, dynamic> item) {
  //   return Column(
  //     children: [
  //       Expanded(
  //         child: ListView.builder(
  //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //           itemCount: widget.cartItems.length,
  //           itemBuilder: (context, index) {
  //             final item = widget.cartItems[index];
  //             return buildOrderSummary(item);
  //           },
  //         ),
  //       ),
  //       _buildOrderSummary(),
  //     ],
  //   );
  // }
  Widget buildOrderSummary(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
                child: item['imageUrl'] != null
                    ? Image.network(
                        item['imageUrl'],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.food_bank,
                          size: 40,
                          color: Colors.grey,
                        ),
                      )
                    : const Icon(
                        Icons.food_bank,
                        size: 40,
                        color: Colors.grey,
                      )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                item['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              if (item['extras'].isNotEmpty)
                Text(
                  'Extras: ${item['extras'].join(", ")}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              const SizedBox(height: 4),
              Text(
                '₦${item['price']}',
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            ),
          ),

          isEditing ? _buildEditQuantityControls(item) : Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'x${item['quantity']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )
            ),
          )
        ],
      ),
    );
  }
  Widget _buildEditQuantityControls(Map<String, dynamic> item) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              _buildQuantityButton(
                icon: Icons.remove,
                onTap: () {
                  setState(() {
                    if (item['quantity'] > 1) {
                      item['quantity']--;
                    } else {
                      // Remove the item if quantity reaches 0
                      widget.cartItems.removeWhere((element) => element['id'] == item['id']);
                    }
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  item['quantity'].toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildQuantityButton(
                icon: Icons.add,
                onTap: () {
                  setState(() {
                    item['quantity']++;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.cartItems.removeWhere((element) => element['id'] == item['id']);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.delete_outline,
                  color: Colors.red[400],
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  'Remove',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityButton({required IconData icon, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                '₦${subtotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Fee',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                '₦${deliveryFee.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₦${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          // Checkout implementation will come later
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Proceed to Checkout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

