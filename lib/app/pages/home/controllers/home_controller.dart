import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heloilo/app/services/shared_service.dart';

class HomeController {
  static final instance = HomeController();

  Future<void> logout(BuildContext context) async {
    try {
      await SharedService.instance.removeWhoIsLoged();
      context.mounted
          ? Navigator.pushReplacementNamed(context, '/login')
          : null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
