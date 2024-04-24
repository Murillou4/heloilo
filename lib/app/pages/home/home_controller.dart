import 'package:flutter/material.dart';
import 'package:heloilo/app/models/desejo.dart';

import '../../services/supabase_service.dart';

class HomeController {
  static final instance = HomeController();

  addDesejo(Desejo desejo, BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));
    try {
      await SupabaseService.instance.addDesejo(desejo);
      context.mounted ? Navigator.pop(context) : null;
    } catch (e) {
      print(e);
    }
  }

  updateDesejo(Desejo desejo, BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));
    try {
      await SupabaseService.instance.updateDesejo(desejo);
      context.mounted ? Navigator.pop(context) : null;
    } catch (e) {
      print(e);
    }
  }
}
