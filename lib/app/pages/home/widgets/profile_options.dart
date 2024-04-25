import 'package:flutter/material.dart';
import 'package:heloilo/app/pages/home/home_controller.dart';

import '../../../services/supabase_service.dart';

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
      child: FutureBuilder(
        future: SupabaseService.instance.getProfileImage(widget.pessoa),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
                        await HomeController.instance
                            .changeProfileImage(widget.pessoa);
                        setState(() {});
                      },
                    ),
                  ];
                },
                child: Image.memory(
                  snapshot.data!,
                  width: 80,
                  height: 80,
                ),
              );
            } else {
              return const Text('erro');
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
