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
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 2),
    ),
  );
}
