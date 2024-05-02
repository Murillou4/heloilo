import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heloilo/app/pages/home/controllers/desejos_controller.dart';
import 'package:heloilo/app/services/shared_service.dart';

import 'package:heloilo/app/src/formatar_data.dart';
import 'package:heloilo/app/src/scaffold_mensage.dart';

import '../../../core/cores.dart';
import '../../../data/user_data.dart';
import '../../../models/desejo.dart';
import 'add_desejo_alertdialog.dart';
import 'visualizar_desejo_alertdialog.dart';

class DesejoCard extends StatefulWidget {
  const DesejoCard({super.key, required this.desejo});
  final Desejo desejo;
  @override
  State<DesejoCard> createState() => _DesejoCardState();
}

class _DesejoCardState extends State<DesejoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 500,
      height: 365,
      decoration: BoxDecoration(
        color: widget.desejo.pessoa == 'murillo'
            ? Cores.corCardMurillo
            : Cores.corCardHeloisa,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.desejo.titulo,
                style: TextStyle(
                  color: widget.desejo.pessoa == 'murillo'
                      ? Cores.corTextoSobreCardMurillo
                      : Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              PopupMenuButton(
                color: Cores.corDeFundoNeutra,
                tooltip: 'Mostrar Menu',
                offset: const Offset(40, 20),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'remover',
                      child: const ListTile(
                        title: Text('Apagar'),
                        trailing: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () async {
                        if (SharedService.instance.whoIsLoged() !=
                            widget.desejo.pessoa) {
                          errorMensage(
                            context,
                            'Você não tem permissão para remover',
                          );
                          return;
                        }
                        await DesejosController.instance
                            .removeDesejo(widget.desejo.id!, context);
                      },
                    ),
                    PopupMenuItem(
                      value: 'editar',
                      child: const ListTile(
                        title: Text('Editar'),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () async {
                        if (SharedService.instance.whoIsLoged() !=
                            widget.desejo.pessoa) {
                          errorMensage(
                              context, 'Você não tem permissão para editar');
                          return;
                        }
                        showDialog(
                          context: context,
                          builder: (context) => AddDesejoAlertDialog(
                            desejo: widget.desejo,
                          ),
                        );
                      },
                    ),
                    PopupMenuItem(
                      value: 'ver',
                      child: const ListTile(
                        title: Text('Ver'),
                        trailing: Icon(
                          Icons.remove_red_eye,
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) => VisualizarDesejoAlertDialog(
                            desejo: widget.desejo,
                          ),
                        );
                      },
                    ),
                  ];
                },
                icon: Icon(
                  Icons.more_vert,
                  color: widget.desejo.pessoa == 'murillo'
                      ? Cores.corTextoSobreCardMurillo
                      : Colors.white,
                ),
              ),
            ],
          ),
          const Gap(10),
          Container(
            width: 450,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFf7f2f9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Cores.corCardMurillo,
              ),
            ),
            child: widget.desejo.imageBinary == null
                ? Icon(
                    Icons.image_not_supported_rounded,
                    size: 50,
                    color: Colors.black,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      base64Decode(widget.desejo.imageBinary!),
                      fit: BoxFit.fill,
                      height: 200,
                      width: 450,
                    ),
                  ),
          ),
          const Gap(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formatarData(DateTime.parse(widget.desejo.data!)),
                style: TextStyle(
                  color: widget.desejo.pessoa == 'murillo'
                      ? Cores.corTextoSobreCardMurillo
                      : Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(65),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nivel de Desejo',
                    style: TextStyle(
                      color: widget.desejo.pessoa == 'murillo'
                          ? Cores.corTextoSobreCardMurillo
                          : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.desejo.nivelDesejo.toString(),
                    style: TextStyle(
                      color: widget.desejo.pessoa == 'murillo'
                          ? Cores.corTextoSobreCardMurillo
                          : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Gap(110),
              AnimatedBuilder(
                animation: UserData.instance,
                builder: (context, snapshot) {
                  return CircleAvatar(
                    radius: 30,
                    backgroundImage: MemoryImage(
                      widget.desejo.pessoa == 'murillo'
                          ? UserData.instance.murilloImageData!
                          : UserData.instance.heloisaImageData!,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
