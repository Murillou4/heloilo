import 'package:flutter/material.dart';
import 'package:heloilo/app/data/user_data.dart';
import 'package:heloilo/app/pages/home/widgets/add_desejo_alertdialog.dart';
import 'package:heloilo/app/pages/loading_page.dart';
import 'package:heloilo/app/services/shared_service.dart';
import 'package:heloilo/app/services/supabase_service.dart';
import 'package:heloilo/app/my_app.dart';

main() async {
  runApp(const LoadingPage());
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.instance.init();
  await SharedService.instance.init();
  await UserData.instance.carregarImagensPerfils();
  
  runApp(
    const MyApp(),
  );
}
