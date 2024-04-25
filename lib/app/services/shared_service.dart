import 'package:heloilo/app/core/shared_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static final instance = SharedService();
  late final SharedPreferences prefs;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? whoIsLoged() {
    return prefs.getString(SharedKeys.whoIsLoged);
  }
  
  Future<void> setWhoIsLoged(String whoIsLoged) async{
    await prefs.setString(SharedKeys.whoIsLoged, whoIsLoged);
  }

  Future<void> removeWhoIsLoged() async{
    await prefs.remove(SharedKeys.whoIsLoged);
  }
}
