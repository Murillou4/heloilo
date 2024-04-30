import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/cores.dart';
import '../../../models/desejo.dart';
import '../../../services/supabase_service.dart';

class DesejosController {
  static final instance = DesejosController();

  Future<void> addDesejo(Desejo desejo, BuildContext context) async {
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
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateDesejo(Desejo desejo, BuildContext context) async {
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
    } catch (e) {
      print(e);
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
