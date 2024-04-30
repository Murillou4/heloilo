import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heloilo/app/models/comentario.dart';

import '../../../core/cores.dart';
import '../../../models/desejo.dart';
import '../../../services/supabase_service.dart';

class ComentariosController {
  static final instance = ComentariosController();

  Future<void> addComentario(
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
      await SupabaseService.instance.addComentario(desejo, comentario);
      context.mounted ? Navigator.pop(context) : null;
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
