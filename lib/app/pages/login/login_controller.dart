import 'package:flutter/material.dart';
import '../../services/shared_service.dart';
import '../../src/scaffold_mensage.dart';

class LoginController {
  static final instance = LoginController();

  final loginTextController = TextEditingController();
  final senhaTextController = TextEditingController();

  String get loginText => loginTextController.text;
  String get senhaText => senhaTextController.text;

  void clearFields() {
    loginTextController.clear();
    senhaTextController.clear();
  }

  login(BuildContext context) async {
    if (loginText.isEmpty || senhaText.isEmpty) {
      errorMensage(context, 'Preencha todos os campos');
    } else {
      if (loginText.toLowerCase() == 'murillo' && senhaText == 'Lilk123456') {
        SharedService.instance.setWhoIsLoged('murillo');
        Navigator.pushReplacementNamed(context, '/home');
        clearFields();
      } else if (loginText.toLowerCase() == 'heloisa' &&
          senhaText == '240327Hp') {
        SharedService.instance.setWhoIsLoged('heloisa');
        Navigator.pushReplacementNamed(context, '/home');
        clearFields();
      } else if (loginText.toLowerCase() == 'admin' &&
          senhaText == 'P@ssW0rd**') {
        SharedService.instance.setWhoIsLoged('admin');
        Navigator.pushReplacementNamed(context, '/home');
        clearFields();
      } else {
        errorMensage(context, 'Login ou senha inválidos');
      }
    }
  }
}
