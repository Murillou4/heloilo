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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Murillo + Heloisa = Amor <3',
                style: TextStyle(
                  color: Cores.corCardMurillo,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
              const Text('Carregando...'),
            ],
          ),
        ),
      ),
    );
  }
}
