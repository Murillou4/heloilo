import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:heloilo/app/core/cores.dart';
import 'package:heloilo/app/pages/login/login_controller.dart';

import '../../widgets/botao_principal.dart';
import '../../widgets/text_field_transparente.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.corDeFundoNeutra,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/images/balao.png',
                  height: 200,
                ),
                Card(
                  elevation: 5,
                  color: Cores.corCardMurillo,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Semantics(
                          label: 'Login',
                          hint: 'Insira o seu login',
                          enabled: true,
                          child: TextFieldTransparente(
                            label: 'Login',
                            controller:
                                LoginController.instance.loginTextController,
                            icon: Icons.person,
                            isPassword: false,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFieldTransparente(
                          label: 'Senha',
                          controller:
                              LoginController.instance.senhaTextController,
                          icon: Icons.lock,
                          isPassword: true,
                        ),
                        const Gap(20),
                        BotaoPrincipal(
                          texto: 'Entrar',
                          onPressed: () async =>
                              await LoginController.instance.login(context),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(200),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                'assets/images/foto_login.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
