import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/cores.dart';
import '../../../models/desejo.dart';
import '../../../services/shared_service.dart';
import '../../../services/supabase_service.dart';
import 'desejo_card.dart';

class DesejosListView extends StatelessWidget {
  const DesejosListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: SupabaseService.supabase.from('desejos').stream(
        primaryKey: ['id'],
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 680,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Desejo desejo = Desejo.fromMap(snapshot.data![index]);

                  if (SharedService.instance.whoIsLoged()! == 'murillo') {
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
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Cores.corDeFundoNeutra,
            ),
          );
        }
        return const Text('erro');
      },
    );
  }
}
