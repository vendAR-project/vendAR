import 'package:dio/dio.dart';
import 'package:vendar/constants.dart';

class RegisterController {
  Dio dio = Dio();

  Future<bool> register(String name, String surname, String email,
      String password, String phone) async {
    const String url = '${Constants.baseUrl}${Constants.registerEndpoint}';
    final Map<String, dynamic> body = {
      "user_name": name,
      "user_surname": surname,
      "user_email": email,
      "user_password": password,
      "user_phone": phone,
      "user_role": "USER"
    };

    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Registration failed: Status code ${response.statusCode}');
      }
    } catch (e) {
      return false;
    }
  }
}
