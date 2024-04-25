import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heloilo/app/core/cores.dart';
import 'package:heloilo/app/models/desejo.dart';
import 'package:heloilo/app/pages/home/widgets/desejo_card.dart';
import 'package:heloilo/app/pages/home/widgets/profile_options.dart';
import 'package:heloilo/app/services/shared_service.dart';
import 'package:heloilo/app/services/supabase_service.dart';

import 'widgets/add_desejo_alertdialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.pessoa});
  final String? pessoa;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color corDeFundo = Colors.white;

  @override
  void initState() {
    super.initState();
    if (widget.pessoa != null) {
      corDeFundo = widget.pessoa == 'murillo'
          ? Cores.corDeFundoMurillo
          : Cores.corDeFundoHeloisa;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corDeFundo,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProfileOptions(pessoa: widget.pessoa!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 220),
            child: StreamBuilder(
              stream: SupabaseService.supabase.from('desejos').stream(
                primaryKey: ['id'],
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 650,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Desejo desejo = Desejo.fromMap(snapshot.data![index]);

                          if (SharedService.instance.whoIsLoged()! ==
                              'murillo') {
                            return desejo.pessoa == 'murillo'
                                ? Align(
                                    alignment: Alignment.topLeft,
                                    child: DesejoCard(desejo: desejo),
                                  )
                                : Align(
                                    alignment: Alignment.topRight,
                                    child: DesejoCard(desejo: desejo),
                                  );
                          } else {
                            return desejo.pessoa == 'heloisa'
                                ? Align(
                                    alignment: Alignment.topLeft,
                                    child: DesejoCard(desejo: desejo),
                                  )
                                : Align(
                                    alignment: Alignment.topRight,
                                    child: DesejoCard(desejo: desejo),
                                  );
                          }
                        },
                        separatorBuilder: (context, index) => const Gap(30),
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Text('erro');
              },
            ),
          ),
        ],
      ),
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
