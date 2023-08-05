import 'package:betweener_app/constants.dart';
import 'package:betweener_app/models/user.dart';
import 'package:http/http.dart' as http;

Future<UserModel> login(Map<String, String> body) async {
  final response = await http.post(
    Uri.parse(loginUrl),
    body: body,
  );

  if (response.statusCode == 200) {
    return userModelFromJson(response.body);
  } else {
    throw Exception('Failed to login');
  }
}
