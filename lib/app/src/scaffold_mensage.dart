import 'package:flutter/material.dart';

import '../core/cores.dart';

errorMensage(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Cores.corTextoSobreCardMurillo,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Cores.corCardMurillo,
      elevation: 5,
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 2),
    ),
  );
}
