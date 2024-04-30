import 'package:flutter/material.dart';
import 'package:heloilo/app/models/desejo.dart';
import 'package:heloilo/app/pages/home/controllers/comentarios_controller.dart';
import 'package:heloilo/app/src/scaffold_mensage.dart';
import 'package:uuid/uuid.dart';

import '../../../core/cores.dart';
import '../../../models/comentario.dart';
import '../../../services/shared_service.dart';
import '../../../services/supabase_service.dart';
import '../../../src/formatar_data.dart';
import '../../../widgets/botao_principal.dart';
import '../../../widgets/text_field_transparente.dart';

class AddComentarioAlertDialog extends StatelessWidget {
  const AddComentarioAlertDialog({super.key, required this.desejo});
  final Desejo desejo;
  @override
  Widget build(BuildContext context) {
    TextEditingController comentarioController = TextEditingController();
    return AlertDialog(
      backgroundColor: Cores.corCardMurillo,
      content: Container(
        padding: const EdgeInsets.all(8.0),
        width: 200,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldTransparente(
              label: 'Comentar',
              controller: comentarioController,
              icon: Icons.comment,
              isPassword: false,
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        BotaoPrincipal(
          texto: 'Cancelar',
          onPressed: () => Navigator.pop(context),
        ),
        BotaoPrincipal(
          texto: 'Comentar',
          onPressed: () async {
            if (comentarioController.text.isNotEmpty) {
              Comentario comentario = Comentario(
                pessoa: SharedService.instance.whoIsLoged()!,
                comentario: comentarioController.text,
                data: formatarData(DateTime.now()),
                id: const Uuid().v4(),
              );
              try {
                await ComentariosController.instance
                    .addComentario(desejo, comentario, context);
                context.mounted ? Navigator.pop(context) : null;
              } catch (e) {
                context.mounted
                    ? errorMensage(context, 'Erro ao comentar')
                    : null;
                context.mounted ? Navigator.pop(context) : null;
              }
            }
          },
        ),
      ],
    );
  }
}
