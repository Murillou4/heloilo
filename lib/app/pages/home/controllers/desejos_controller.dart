import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/cores.dart';
import '../../../models/desejo.dart';
import '../../../services/shared_service.dart';
import '../../../services/supabase_service.dart';
import '../../../src/scaffold_mensage.dart';

class DesejosController {
  static final instance = DesejosController();
  TextEditingController tituloController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  int nivelDesejo = 1;
  Uint8List? imagemData;

  void clearFields() {
    tituloController.clear();
    linkController.clear();
    nivelDesejo = 1;
    imagemData = null;
  }

  Future<bool> addDesejo(BuildContext context) async {
    if (tituloController.text.isEmpty) {
      errorMensage(context, 'Insira um título');
      return false;
    }
    Desejo desejo = Desejo(
      titulo: tituloController.text,
      pessoa: SharedService.instance.whoIsLoged()!,
      link: linkController.text,
      imageBinary: imagemData == null ? null : base64Encode(imagemData!),
      nivelDesejo: nivelDesejo,
    );
    showDialog(
      context: context,
      builder: (_) => Center(
        child: CircularProgressIndicator(
          color: Cores.corDeFundoNeutra,
        ),
      ),
      barrierDismissible: false,
    );
    try {
      await SupabaseService.instance.addDesejo(desejo);
      context.mounted ? Navigator.pop(context) : null;
      clearFields();
      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }

  Future<bool> updateDesejo(Desejo desejo, BuildContext context) async {
    if (desejo.titulo.isEmpty) {
      errorMensage(context, 'Insira um título');
      return false;
    }

    desejo.titulo = tituloController.text;
    desejo.nivelDesejo = nivelDesejo;
    desejo.link = linkController.text;
    desejo.imageBinary = imagemData == null ? null : base64Encode(imagemData!);

    showDialog(
      context: context,
      builder: (_) => Center(
        child: CircularProgressIndicator(
          color: Cores.corDeFundoNeutra,
        ),
      ),
      barrierDismissible: false,
    );
    try {
      await SupabaseService.instance.updateDesejo(desejo);
      context.mounted ? Navigator.pop(context) : null;
      clearFields();
      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }

  Future<void> removeDesejo(String id, BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: CircularProgressIndicator(
          color: Cores.corDeFundoNeutra,
        ),
      ),
      barrierDismissible: false,
    );
    try {
      await SupabaseService.instance.removeDesejo(id);
      context.mounted ? Navigator.pop(context) : null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
