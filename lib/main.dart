import 'package:flutter/material.dart';
import 'package:heloilo/app/pages/home/widgets/add_desejo_alertdialog.dart';
import 'package:heloilo/app/services/shared_service.dart';
import 'package:heloilo/app/services/supabase_service.dart';
import 'package:heloilo/app/my_app.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.instance.init();
  await SharedService.instance.init();

  runApp(
    const MyApp(),
  );
}
