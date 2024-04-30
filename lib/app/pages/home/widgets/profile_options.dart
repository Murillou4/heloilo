import 'package:flutter/material.dart';
import 'package:heloilo/app/data/user_data.dart';
import 'package:heloilo/app/pages/home/controllers/home_controller.dart';

import '../../../core/cores.dart';


class ProfileOptions extends StatefulWidget {
  const ProfileOptions({super.key, required this.pessoa});
  final String pessoa;

  @override
  State<ProfileOptions> createState() => _ProfileOptionsState();
}

class _ProfileOptionsState extends State<ProfileOptions> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: AnimatedBuilder(
        animation: UserData.instance,
        builder: (context, child) {
          return PopupMenuButton(
            color: Cores.corDeFundoNeutra,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            splashRadius: 20,
            offset: const Offset(0, 50),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'sair',
                  child: Text('Sair'),
                  onTap: () => HomeController.instance.logout(context),
                ),
                PopupMenuItem(
                  value: 'editar',
                  child: Text('Editar imagem'),
                  onTap: () async {
                    await UserData.instance
                        .changeProfileImage(widget.pessoa, context);
                  },
                ),
              ];
            },
            child: Image.memory(
              widget.pessoa == 'heloisa'
                  ? UserData.instance.heloisaImageData!
                  : UserData.instance.murilloImageData!,
              width: 80,
              height: 80,
            ),
          );
        },
      ),
    );
  }
}
