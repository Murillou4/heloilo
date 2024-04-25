import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heloilo/app/core/cores.dart';
import 'package:heloilo/app/models/desejo.dart';
import 'package:heloilo/app/pages/home/home_controller.dart';
import 'package:heloilo/app/src/scaffold_mensage.dart';
import 'package:heloilo/app/widgets/botao_principal.dart';
import 'package:heloilo/app/widgets/text_field_transparente.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/shared_service.dart';
import '../../../services/supabase_service.dart';

class AddDesejoAlertDialog extends StatefulWidget {
  const AddDesejoAlertDialog({super.key, this.desejo});
  final Desejo? desejo;
  @override
  State<AddDesejoAlertDialog> createState() => _AddDesejoAlertDialogState();
}

class _AddDesejoAlertDialogState extends State<AddDesejoAlertDialog> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  int nivelDesejo = 1;
  Uint8List? imagemData;
  String textoBotao = 'Adicionar';

  @override
  void initState() {
    super.initState();
    if (widget.desejo != null) {
      tituloController.text = widget.desejo!.titulo;
      linkController.text = widget.desejo!.link ?? '';
      nivelDesejo = widget.desejo!.nivelDesejo;
      imagemData = widget.desejo!.imageBinary != null
          ? base64Decode(widget.desejo!.imageBinary!)
          : null;

      textoBotao = 'Atualizar';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Cores.corDeFundoNeutra,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFieldTransparente(
            label: 'Titulo',
            controller: tituloController,
            icon: Icons.title,
            isPassword: false,
          ),
          const Gap(10),
          TextFieldTransparente(
            label: 'Link',
            controller: linkController,
            icon: Icons.link,
            isPassword: false,
          ),
          const Gap(10),
          Container(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFf7f2f9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Cores.corCardMurillo,
              ),
            ),
            child: Center(
              child: InkWell(
                onTap: () async {
                  XFile? imagemFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (imagemFile != null) {
                    imagemData = await imagemFile.readAsBytes();
                    if (widget.desejo != null) {
                      widget.desejo!.imageBinary = base64Encode(imagemData!);
                    }
                    setState(() {});
                  }
                },
                child: imagemData == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: 50,
                        color: Cores.corTextoSobreCardMurillo,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          imagemData!,
                          fit: BoxFit.fill,
                          height: 200,
                          width: 350,
                        ),
                      ),
              ),
            ),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Nivel de Desejo',
                style: TextStyle(
                  color: Cores.corTextoSobreCardMurillo,
                  fontSize: 18,
                ),
              ),
              const Gap(5),
              DropdownButton<int>(
                value: nivelDesejo,
                onChanged: (value) {
                  setState(() {
                    nivelDesejo = value!;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                dropdownColor: Cores.corCardMurillo,
                underline: Container(),
                elevation: 0,
                focusColor: Cores.corCardMurillo,
                alignment: Alignment.center,
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('1 - Legalzinho'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('2 - Bacana, gostei!'),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text('3 - Caralho, muito foda kkk'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        BotaoPrincipal(
          texto: 'Cancelar',
          onPressed: () => Navigator.pop(context),
        ),
        BotaoPrincipal(
          texto: textoBotao,
          onPressed: () async {
            if (tituloController.text.isNotEmpty) {
              if (widget.desejo != null) {
                widget.desejo!.titulo = tituloController.text;
                widget.desejo!.link = linkController.text;
                widget.desejo!.nivelDesejo = nivelDesejo;
                await HomeController.instance
                    .updateDesejo(widget.desejo!, context);
                context.mounted ? Navigator.pop(context) : null;
                return;
              }
              Desejo desejo = Desejo(
                titulo: tituloController.text,
                pessoa: SharedService.instance.whoIsLoged()!,
                link: linkController.text,
                imageBinary:
                    imagemData == null ? null : base64Encode(imagemData!),
                nivelDesejo: nivelDesejo,
              );
              await HomeController.instance.addDesejo(desejo, context);
              context.mounted ? Navigator.pop(context) : null;
              return;
            } else {
              errorMensage(context, 'Preencha o campo de titulo');
            }
          },
        )
      ],
    );
  }
}
