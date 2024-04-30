import 'package:flutter/material.dart';
import 'package:heloilo/app/core/cores.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Cores.corDeFundoNeutra,
        body: Center(
          child: CircularProgressIndicator(
            color: Cores.corDeFundoHeloisa,
          ),
        ),
      ),
    );
  }
}
