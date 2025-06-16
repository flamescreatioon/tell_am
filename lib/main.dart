import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/profile/profile.dart';
import 'screens/customer/home_screen.dart';
import 'screens/customer/buka_screen.dart';
import 'screens/buka_owner/buka_dashboard.dart';
import 'screens/customer/cart_screen.dart';
import 'screens/profile/notification_screen.dart';
import 'screens/customer/food_detail_screen.dart';
import 'components/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: LoginScreen(),

      // Static routes for screens without parameters
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/register': (context) => const RegisterScreen(),
        '/all_buka': (context) => const BukaScreen(),
        '/cart': (context) => const Cart(
              cartItems: [],
            ),
        '/notif': (context) => const NotificationScreen(),
      },

      // Dynamic routes for screens that need parameters
      onGenerateRoute: (RouteSettings settings) {
        // Extract route name and arguments
        final routeName = settings.name;
        final args = settings.arguments;

        switch (routeName) {
          case '/buka-detail':
            if (args is Map<String, dynamic> && args.containsKey('bukaId')) {
              return MaterialPageRoute(
                builder: (context) => BukaDashboard(
                  bukaId: args['bukaId'],
                ),
              );
            }
            // If arguments are invalid, redirect to home
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );

          // Add more dynamic routes here
          case '/menu':
            if (args is Map<String, dynamic> &&
                args.containsKey('categoryId')) {
              // Return your menu screen with category
              return MaterialPageRoute(
                builder: (context) =>
                    const HomeScreen(), // Replace with actual MenuScreen
              );
            }
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );

          // Handle unknown routes
          default:
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: const Text('Not Found'),
                ),
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
            );
        }
      },

      // Handle routes that weren't found
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Not Found'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Page not found!',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
                      );
                    },
                    child: const Text('Go to Home'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
