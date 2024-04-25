import 'package:dio/dio.dart';
import 'package:vendar/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  Dio dio = Dio();

  Future<void> login(String email, String password) async {
    final String url =
        "http://54.93.83.196:8080/login"; // TODO: keep such urls in a file named constants.dart then fetch it here for encapsulation
    final Map<String, dynamic> body = {
      "user_email": email,
      "user_password": password
    };

    try {
      Response response = await dio.post(url, data: body);
      // Handle the response as necessary
      print('Login Successful: ${response.data}');
      await _saveToken(response.data['token']);
    } catch (e) {
      // Handle errors or exceptions
      print('Error occurred: $e');
    }
  }

  Future<void> _saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
    print('Token saved');
  }
}
