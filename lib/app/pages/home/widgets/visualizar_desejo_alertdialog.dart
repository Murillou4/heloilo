import 'dart:convert';
import 'dart:typed_data';
import 'package:heloilo/app/src/scaffold_mensage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heloilo/app/models/desejo.dart';

import '../../../core/cores.dart';
import '../../../src/formatar_data.dart';
import '../../../widgets/botao_principal.dart';

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
        width: MediaQuery.of(context).size.width * 0.5,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                                width: 300,
                                height: 250,
                                fit: BoxFit.fill,
                              )
                            : Container(
                                width: 300,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Titulo - ${widget.desejo.titulo}',
                              style: TextStyle(
                                color: Cores.corTextoSobreCardMurillo,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget.desejo.link != null) {
                                  try {
                                    await launchUrl(
                                      Uri.parse(
                                        widget.desejo.link!,
                                      ),
                                    );
                                  } catch (e) {
                                    errorMensage(context, 'Link inválido');
                                  }
                                } else {
                                  errorMensage(context, 'Link inválido');
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                            Text(
                              'Criado por: ${widget.desejo.pessoa}',
                              style: TextStyle(
                                color: Cores.corTextoSobreCardMurillo,
                                fontSize: 18,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              'Data: ${formatarData(DateTime.parse(widget.desejo.data!))}',
                              style: TextStyle(
                                color: Cores.corTextoSobreCardMurillo,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
