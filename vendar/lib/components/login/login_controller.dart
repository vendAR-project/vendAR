import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendar/constants.dart';

class LoginController {
  Dio dio = Dio();

  Future<bool> login(String email, String password) async {
    const String url =
        '${Constants.baseUrl}${Constants.loginEndpoint}'; // Use constants
    final Map<String, dynamic> body = {
      "user_email": email,
      "user_password": password,
    };

    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        await _saveToken(response.data['token']);
        return true;
      } else {
        throw Exception('Login failed: Status code ${response.statusCode}');
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
  }
}
