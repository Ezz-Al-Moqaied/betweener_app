import 'dart:convert';
import 'package:betweener_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setIsLogged(bool isLogged) async {
    return await sharedPreferences.setBool('isLogged', isLogged);
  }

  static Future<bool> setIsDisclaimer(bool isDisclaimer) async {
    return await sharedPreferences.setBool('isDisclaimer', isDisclaimer);
  }

  static Future<bool> setPassword(String password) async {
    return await sharedPreferences.setString('password', password);
  }

  static Future<bool> setIdUser(String idUser) {
    return sharedPreferences.setString('idUser', idUser);
  }

  static bool get isLogged {
    return sharedPreferences.getBool('isLogged') ?? false;
  }

  static bool get isDisclaimer {
    return sharedPreferences.getBool('isDisclaimer') ?? false;
  }

  static String? get idUser {
    return sharedPreferences.getString('idUser');
  }

  static String? get password {
    return sharedPreferences.getString('password');
  }

  static Future<bool> setUser(UserModel users) async {
    return await sharedPreferences.setString(
        "user", jsonEncode(userModelToJson(user)));
  }

  static UserModel get user {
    final map = jsonDecode(sharedPreferences.getString("user")!);
    return UserModel.fromJson(map);
  }
}
