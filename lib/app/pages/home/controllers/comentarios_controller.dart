import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heloilo/app/models/comentario.dart';
import 'package:heloilo/app/services/shared_service.dart';
import 'package:heloilo/app/src/formatar_data.dart';
import 'package:heloilo/app/src/scaffold_mensage.dart';
import 'package:uuid/uuid.dart';

import '../../../core/cores.dart';
import '../../../models/desejo.dart';
import '../../../services/supabase_service.dart';

class ComentariosController {
  static final instance = ComentariosController();
  TextEditingController comentarioController = TextEditingController();
  Future<void> addComentario(Desejo desejo, BuildContext context) async {
    if (comentarioController.text.isEmpty) {
      errorMensage(context, 'Insira um comentário');
      return;
    }
    final comentario = Comentario(
      id: const Uuid().v4(),
      pessoa: SharedService.instance.whoIsLoged()!,
      comentario: comentarioController.text,
      data: formatarData(DateTime.now()),
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
      await SupabaseService.instance.addComentario(desejo, comentario);
      context.mounted ? Navigator.pop(context) : null;
      ComentariosController.instance.comentarioController.clear();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      context.mounted ? Navigator.pop(context) : null;
    }
  }

  Future<void> updateComentarios(
      Desejo desejo, Comentario comentario, BuildContext context) async {
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
      await SupabaseService.instance.updateComentarios(desejo, comentario);
      context.mounted ? Navigator.pop(context) : null;
      ComentariosController.instance.comentarioController.clear();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      context.mounted ? Navigator.pop(context) : null;
    }
  }

  Future<void> removeComentario(
      Desejo desejo, Comentario comentario, BuildContext context) async {
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
      await SupabaseService.instance.removeComentario(desejo, comentario);
      context.mounted ? Navigator.pop(context) : null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      context.mounted ? Navigator.pop(context) : null;
    }
  }
}
