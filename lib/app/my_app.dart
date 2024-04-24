import 'package:flutter/material.dart';
import 'package:heloilo/app/routes/routes.dart';
import 'package:heloilo/app/services/shared_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: 'Heloilo',
      routes: routes,
      initialRoute:
          SharedService.instance.whoIsLoged() != null ? '/home' : '/login',
    );
  }
}
