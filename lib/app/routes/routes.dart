import 'package:flutter/material.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => const LoginPage(),
  '/home': (context) => const HomePage(),
};
