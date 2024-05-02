import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heloilo/app/data/user_data.dart';
import 'package:heloilo/app/pages/home/controllers/home_controller.dart';
import 'package:heloilo/app/services/shared_service.dart';

import '../../../core/cores.dart';

class ProfileOptions extends StatefulWidget {
  const ProfileOptions({super.key});
  

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
            constraints: const BoxConstraints(maxHeight: 300, maxWidth: 150),
            tooltip: 'Opções do perfil',
            color: Cores.corDeFundoNeutra,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            splashRadius: 20,
            offset: const Offset(0, 50),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'sair',
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Sair',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Gap(5),
                      Icon(Icons.logout),
                    ],
                  ),
                  onTap: () => HomeController.instance.logout(context),
                ),
                PopupMenuItem(
                  value: 'editar',
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Editar imagem',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(5),
                      Icon(Icons.edit),
                    ],
                  ),
                  onTap: () async {
                    await UserData.instance
                        .changeProfileImage(SharedService.instance.whoIsLoged()!, context);
                  },
                ),
              ];
            },
            child: Image.memory(
              SharedService.instance.whoIsLoged()! == 'admin'
                  ? UserData.instance.adminImageData!
                  : SharedService.instance.whoIsLoged()! == 'murillo'
                      ? UserData.instance.murilloImageData!
                      : UserData.instance.heloisaImageData!,
              width: 80,
              height: 80,
            ),
          );
        },
      ),
    );
  }
}
