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

  static bool get isLogged {
    return sharedPreferences.getBool('isLogged') ?? false;
  }

  static Future<bool> setUser(UserModel users) async {
    bool isLogged =
        await sharedPreferences.setString("user", jsonEncode(users.toJson()));
    if (isLogged) {
      setIsLogged(true);
    } else {
      setIsLogged(false);
    }
    return isLogged;
  }

  static UserModel get user {
    final map = jsonDecode(sharedPreferences.getString("user")!);
    return UserModel.fromJson(map);
  }
}
