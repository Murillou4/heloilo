import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heloilo/app/models/comentario.dart';
import 'package:heloilo/app/pages/home/controllers/comentarios_controller.dart';
import 'package:heloilo/app/src/scaffold_mensage.dart';

import '../../../core/cores.dart';
import '../../../data/user_data.dart';
import '../../../models/desejo.dart';
import 'add_comentario_alertdialog.dart';

class ComentarioListTile extends StatelessWidget {
  const ComentarioListTile(
      {super.key, required this.comentario, required this.desejo});
  final Comentario comentario;
  final Desejo desejo;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Cores.corDeFundoHeloisa,
      child: ListTile(
        title: Text(
          comentario.pessoa,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          comentario.comentario,
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.memory(
            comentario.pessoa == 'murillo'
                ? UserData.instance.murilloImageData!
                : UserData.instance.heloisaImageData!,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {
                try {
                  await ComentariosController.instance
                      .removeComentario(desejo, comentario, context);
                } catch (e) {
                  context.mounted ? errorMensage(context, '$e') : null;
                }
              },
            ),
            const Gap(5),
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (_) => AddComentarioAlertDialog(
                    desejo: desejo,
                    comentario: comentario,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
