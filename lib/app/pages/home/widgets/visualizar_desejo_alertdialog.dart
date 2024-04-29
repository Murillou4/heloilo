import 'dart:convert';
import 'package:heloilo/app/data/user_data.dart';
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
        width: 780,
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
                        borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                child: Center(
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
                      color: Color.fromARGB(255, 120, 163, 120),
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
                                    return Card(
                                      color: Cores.corDeFundoHeloisa,
                                      child: ListTile(
                                        title: Text(
                                          desejo.comentarios[index].pessoa,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        subtitle: Text(
                                          desejo.comentarios[index].comentario,
                                          style: TextStyle(
                                            color: Colors.black87,
                                          ),
                                        ),
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.memory(
                                            desejo.comentarios[index].pessoa ==
                                                    'murillo'
                                                ? UserData
                                                    .instance.murilloImageData!
                                                : UserData
                                                    .instance.heloisaImageData!,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () async {
                                            await SupabaseService.instance
                                                .removeComentario(desejo,
                                                    desejo.comentarios[index]);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Gap(5),
                                  itemCount: desejo.comentarios.length,
                                );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  const Gap(10),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController comentarioController =
                              TextEditingController();
                          return AlertDialog(
                            backgroundColor: Cores.corCardMurillo,
                            content: Container(
                              padding: EdgeInsets.all(8.0),
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
                                      pessoa:
                                          SharedService.instance.whoIsLoged()!,
                                      comentario: comentarioController.text,
                                      data: formatarData(DateTime.now()),
                                      id: Uuid().v4(),
                                    );

                                    await SupabaseService.instance
                                        .addComentario(
                                            widget.desejo, comentario);
                                    setState(() {});
                                    context.mounted
                                        ? Navigator.pop(context)
                                        : null;
                                  }
                                  setState(() {});
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.add_comment_rounded,
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
