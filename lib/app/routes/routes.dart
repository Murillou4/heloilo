import 'package:flutter/material.dart';
import 'package:heloilo/app/services/shared_service.dart';

import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => const LoginPage(),
  '/home': (context) => HomePage(pessoa: SharedService.instance.whoIsLoged()),
};
