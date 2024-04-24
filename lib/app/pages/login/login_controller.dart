import 'package:flutter/material.dart';
import 'package:heloilo/app/core/cores.dart';

import '../../services/shared_service.dart';

class LoginController {
  static final instance = LoginController();

  final loginTextController = TextEditingController();
  final senhaTextController = TextEditingController();

  String get loginText => loginTextController.text;
  String get senhaText => senhaTextController.text;

  login(BuildContext context) async {
    if (loginText.isEmpty || senhaText.isEmpty) {
      errorMensage(context, 'Preencha todos os campos');
    } else {
      if (loginText.toLowerCase() == 'murillo' && senhaText == 'Lilk123456') {
        SharedService.instance.setWhoIsLoged('murillo');
        Navigator.pushReplacementNamed(context, '/home');
      } else if (loginText.toLowerCase() == 'heloisa' &&
          senhaText == '240327Hp') {
        SharedService.instance.setWhoIsLoged('heloisa');
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        errorMensage(context, 'Login ou senha inválidos');
      }
    }
  }

  errorMensage(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Cores.corTextoSobreCardMurillo,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Cores.corCardMurillo,
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
