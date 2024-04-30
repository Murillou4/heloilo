import 'dart:convert';
import 'package:heloilo/app/data/user_data.dart';
import 'package:heloilo/app/pages/home/widgets/add_comentario_alertdialog.dart';
import 'package:heloilo/app/services/shared_service.dart';
import 'package:heloilo/app/src/scaffold_mensage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heloilo/app/models/desejo.dart';
import 'package:uuid/uuid.dart';

import '../../../core/cores.dart';
import '../../../models/comentario.dart';
import '../../../services/supabase_service.dart';
import '../../../src/formatar_data.dart';
import '../../../widgets/botao_principal.dart';
import '../../../widgets/text_field_transparente.dart';
import 'comentario_listitle.dart';

class VisualizarDesejoAlertDialog extends StatefulWidget {
  const VisualizarDesejoAlertDialog({super.key, required this.desejo});
  final Desejo desejo;
  @override
  State<VisualizarDesejoAlertDialog> createState() =>
      _VisualizarDesejoAlertDialogState();
}

class _VisualizarDesejoAlertDialogState
    extends State<VisualizarDesejoAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Cores.corDeFundoNeutra,
      content: SizedBox(
        width: 850,
        height: 550,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: widget.desejo.imageBinary != null
                            ? Image.memory(
                                base64Decode(widget.desejo.imageBinary!),
                                width: 550,
                                height: 250,
                                fit: BoxFit.fill,
                              )
                            : Container(
                                width: 550,
                                height: 250,
                                color: Colors.white,
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported_rounded,
                                    color: Colors.black,
                                    size: 50,
                                  ),
                                ),
                              ),
                      ),
                      const Gap(20),
                      SizedBox(
                        height: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  widget.desejo.titulo,
                                  style: TextStyle(
                                    color: Cores.corTextoSobreCardMurillo,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (widget.desejo.link != null) {
                                      try {
                                        await launchUrl(
                                          Uri.parse(
                                            widget.desejo.link!,
                                          ),
                                        );
                                      } catch (e) {
                                        context.mounted
                                            ? errorMensage(
                                                context, 'Link inválido')
                                            : null;
                                      }
                                    } else {
                                      errorMensage(context, 'Link inválido');
                                    }
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Link',
                                        style: TextStyle(
                                          color: Cores.corTextoSobreCardMurillo,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const Gap(5),
                                      Icon(
                                        Icons.link,
                                        color: Cores.corTextoSobreCardMurillo,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Criado por: ${widget.desejo.pessoa}',
                                  style: TextStyle(
                                    color: Cores.corTextoSobreCardMurillo,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  formatarData(
                                      DateTime.parse(widget.desejo.data!)),
                                  style: TextStyle(
                                    color: Cores.corTextoSobreCardMurillo,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(20),
              Text(
                'Comentários',
                style: TextStyle(
                  color: Cores.corTextoSobreCardMurillo,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 550,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 120, 163, 120),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Cores.corCardMurillo,
                      ),
                    ),
                    child: StreamBuilder(
                      stream: SupabaseService.supabase.from('desejos').stream(
                        primaryKey: [
                          'id',
                        ],
                      ).eq('id', widget.desejo.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          Desejo desejo = Desejo.fromMap(snapshot.data!.first);
                          return desejo.comentarios.isEmpty
                              ? Center(
                                  child: Text(
                                    'Sem comentários',
                                    style: TextStyle(
                                      color: Cores.corTextoSobreCardMurillo,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    return ComentarioListTile(
                                      comentario: desejo.comentarios[index],
                                      desejo: desejo,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Gap(5),
                                  itemCount: desejo.comentarios.length,
                                );
                        }
                        return CircularProgressIndicator(
                          color: Cores.corDeFundoNeutra,
                        );
                      },
                    ),
                  ),
                  const Gap(10),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddComentarioAlertDialog(
                            desejo: widget.desejo,
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.post_add_rounded,
                      color: Cores.corDeFundoHeloisa,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        BotaoPrincipal(
          texto: 'Fechar',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
