import 'package:flutter/cupertino.dart';
import 'package:vb_grocery/screens/home_screen.dart';
import 'package:vb_grocery/screens/splash_screen.dart';
import '../screens/subcategory_screen.dart';

class RouteScreen {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const SplashScreen(),
    '/Home': (context) => HomeScreen(),

  };
}
