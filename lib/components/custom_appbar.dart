import 'package:flutter/material.dart';
import '../models/cart_manager.dart';
// import '../routes/app_routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCart;
  final bool showNotification;
  final bool showBackButton;
  final bool showFavourites;
  final bool showShare;
  final bool showBin;
  final List<Widget>? additionalActions;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showCart = true,
    this.showNotification = true,
    this.showBackButton = true,
    this.showFavourites = false,
    this.showShare = false,
    this.showBin = true,
    this.additionalActions,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      // backgroundColor: Colors.white,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            )
          : null,
      actions: [
        if (showCart)
          CartIconWithBadge(
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        if (showNotification)
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, '/notif'),
          ),
        if (showFavourites)
          IconButton(
            icon: const Icon(Icons.favorite_rounded, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, '/notif'),
          ),
        if (additionalActions != null) ...additionalActions!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Cart icon with badge showing item count
class CartIconWithBadge extends StatelessWidget {
  final VoidCallback onPressed;

  const CartIconWithBadge({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          onPressed: onPressed,
        ),
        if (CartManager().cartItems.isNotEmpty)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                CartManager().cartItems.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

// Optional: Create variant AppBars for specific use cases
class HomeAppBar extends CustomAppBar {
  const HomeAppBar({
    super.key,
    super.title = 'Home',
    super.additionalActions,
  }) : super(
          showBackButton: false,
          showCart: true,
          showNotification: true,
        );
}

class DetailAppBar extends CustomAppBar {
  const DetailAppBar({
    super.key,
    required super.title,
    super.additionalActions,
  }) : super(
          showBackButton: true,
          showCart: true,
          showNotification: false,
        );
}

class CartAppBar extends CustomAppBar {
  const CartAppBar({
    super.key,
    super.title = 'My Cart',
    super.additionalActions,
  }) : super(
          showBackButton: true,
          showCart: false,
          showNotification: false,
        );
}

class BukaDashAppBar extends CustomAppBar {
  const BukaDashAppBar({
    super.key,
    super.title = 'My Cart',
    super.additionalActions,
  }) : super(
            showBackButton: true,
            showCart: false,
            showNotification: false,
            showFavourites: true,
            showShare: true);
}

class NotificationAppBar extends CustomAppBar {
  final VoidCallback? onClearAll;

  NotificationAppBar({
    super.key,
    super.title = 'Notifications',
    this.onClearAll,
    bool showDeleteButton = true,
  }) : super(
          showBackButton: true,
          showCart: false,
          showNotification: false,
          additionalActions: showDeleteButton
              ? [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (onClearAll != null) {
                          // Show confirmation dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Clear All Notifications?'),
                                content: const Text(
                                  'This will remove all your notifications. This action cannot be undone.',
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      onClearAll();
                                    },
                                    child: const Text(
                                      'Clear All',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      tooltip: 'Clear all notifications',
                    ),
                  ),
                ]
              : null,
        );
}
