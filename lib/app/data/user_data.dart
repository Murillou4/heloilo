import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:heloilo/app/services/supabase_service.dart';
import 'package:heloilo/app/src/image_picker.dart';
import 'package:image_picker/image_picker.dart';

class UserData extends ChangeNotifier {
  static final UserData instance = UserData();

  Uint8List? heloisaImageData;
  Uint8List? murilloImageData;
  Uint8List? adminImageData;
  Future<void> carregarImagensPerfils() async {
    heloisaImageData =
        await SupabaseService.instance.getProfileImage('heloisa');
    murilloImageData =
        await SupabaseService.instance.getProfileImage('murillo');
    adminImageData = await SupabaseService.instance.getProfileImage('admin');
    notifyListeners();
  }

  Future<void> changeProfileImage(String pessoa, BuildContext context) async {
    try {
      XFile? imageFile = await pickImage();
      if (imageFile != null) {
        context.mounted
            ? showDialog(
                context: context,
                builder: (_) => const Center(
                  child: CircularProgressIndicator(),
                ),
                barrierDismissible: false,
              )
            : null;
        await SupabaseService.instance.changeProfileImage(pessoa, imageFile);
        await carregarImagensPerfils();
        context.mounted ? Navigator.pop(context) : null;
        notifyListeners();
      } else {
        return;
      }
    } catch (e) {
      rethrow;
    }
  }
}
