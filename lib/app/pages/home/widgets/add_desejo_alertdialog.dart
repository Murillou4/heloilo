import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heloilo/app/core/cores.dart';
import 'package:heloilo/app/models/desejo.dart';
import 'package:heloilo/app/pages/home/controllers/desejos_controller.dart';

import 'package:heloilo/app/widgets/botao_principal.dart';
import 'package:heloilo/app/widgets/text_field_transparente.dart';
import 'package:image_picker/image_picker.dart';

class AddDesejoAlertDialog extends StatefulWidget {
  const AddDesejoAlertDialog({super.key, this.desejo});
  final Desejo? desejo;
  @override
  State<AddDesejoAlertDialog> createState() => _AddDesejoAlertDialogState();
}

class _AddDesejoAlertDialogState extends State<AddDesejoAlertDialog> {
  String textoBotao = 'Adicionar';

  @override
  void initState() {
    super.initState();
    if (widget.desejo != null) {
      DesejosController.instance.tituloController.text = widget.desejo!.titulo;
      DesejosController.instance.linkController.text =
          widget.desejo!.link ?? '';
      DesejosController.instance.nivelDesejo = widget.desejo!.nivelDesejo;
      DesejosController.instance.imagemData = widget.desejo!.imageBinary != null
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
            controller: DesejosController.instance.tituloController,
            icon: Icons.title,
            isPassword: false,
          ),
          const Gap(10),
          TextFieldTransparente(
            label: 'Link',
            controller: DesejosController.instance.linkController,
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
                    DesejosController.instance.imagemData =
                        await imagemFile.readAsBytes();
                    if (widget.desejo != null) {
                      widget.desejo!.imageBinary =
                          base64Encode(DesejosController.instance.imagemData!);
                    }
                    setState(() {});
                  }
                },
                child: DesejosController.instance.imagemData == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: 50,
                        color: Cores.corTextoSobreCardMurillo,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          DesejosController.instance.imagemData!,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nivel de Desejo',
                style: TextStyle(
                  color: Cores.corTextoSobreCardMurillo,
                  fontSize: 18,
                ),
              ),
              DropdownButton<int>(
                value: DesejosController.instance.nivelDesejo,
                onChanged: (value) {
                  setState(() {
                    DesejosController.instance.nivelDesejo = value!;
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
                    child: Text('2 - Bacana, gostei'),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text('3 - Caralho, muito foda'),
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
            if (widget.desejo != null) {
              bool sucesso = await DesejosController.instance
                  .updateDesejo(widget.desejo!, context);

              sucesso
                  ? context.mounted
                      ? Navigator.pop(context)
                      : null
                  : null;
              return;
            }

            bool sucesso = await DesejosController.instance.addDesejo(context);
            sucesso
                ? context.mounted
                    ? Navigator.pop(context)
                    : null
                : null;
            return;
          },
        )
      ],
    );
  }
}
