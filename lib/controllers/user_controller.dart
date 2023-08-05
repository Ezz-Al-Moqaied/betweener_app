import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

Future<UserModel> getLocalUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('user')) {
    return userModelFromJson(prefs.getString('user')!);
  }
  return Future.error('not found');
}
