import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:heloilo/app/models/desejo.dart';
import 'package:heloilo/app/services/shared_service.dart';
import 'package:heloilo/app/src/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/supabase_service.dart';

class HomeController {
  static final instance = HomeController();

  Future<void> addDesejo(Desejo desejo, BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
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
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
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
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    try {
      await SupabaseService.instance.removeDesejo(id);
      context.mounted ? Navigator.pop(context) : null;
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await SharedService.instance.removeWhoIsLoged();
      context.mounted
          ? Navigator.pushReplacementNamed(context, '/login')
          : null;
    } catch (e) {
      print(e);
    }
  }
}
