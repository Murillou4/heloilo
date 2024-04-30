import 'package:flutter/material.dart';
import 'package:heloilo/app/core/cores.dart';
import 'package:heloilo/app/pages/home/widgets/profile_options.dart';
import 'package:heloilo/app/services/shared_service.dart';
import 'widgets/add_desejo_alertdialog.dart';
import 'widgets/desejos_listview.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color corDeFundo = Colors.white;

  @override
  void initState() {
    super.initState();
    if (SharedService.instance.whoIsLoged() != null) {
      corDeFundo = SharedService.instance.whoIsLoged() == 'murillo'
          ? Cores.corDeFundoMurillo
          : Cores.corDeFundoHeloisa;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corDeFundo,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfileOptions(pessoa: SharedService.instance.whoIsLoged()!),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 220),
              child: DesejosListView(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          showDialog(
              context: context, builder: (_) => const AddDesejoAlertDialog());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
