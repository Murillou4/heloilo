import 'package:flutter/material.dart';

import 'widgets/add_desejo_alertdialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.pessoa});
  final String? pessoa;
  @override
  Widget build(BuildContext context) {
    pessoa == null ? Navigator.pushReplacementNamed(context, '/login') : null;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (_) => const AddDesejoAlertDialog());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
