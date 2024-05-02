import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:heloilo/app/core/cores.dart';
import 'package:heloilo/app/pages/login/login_controller.dart';

import '../../widgets/botao_principal.dart';
import '../../widgets/text_field_transparente.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 20).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) async {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          await LoginController.instance.login(context);
        }
      },
      child: Scaffold(
        backgroundColor: Cores.corDeFundoNeutra,
        body: Stack(
          children: [
            Center(
              child: Transform.translate(
                offset: Offset(0, _animation.value),
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
                                controller: LoginController
                                    .instance.loginTextController,
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
      ),
    );
  }
}
