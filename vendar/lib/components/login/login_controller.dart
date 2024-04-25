import 'package:dio/dio.dart';

class LoginController {
  Dio dio = Dio();

  Future<void> login(String email, String password) async {
    final String url = "http://54.93.83.196:8080/login";
    final Map<String, dynamic> body = {
      "user_email": email,
      "user_password": password
    };

    try {
      Response response = await dio.post(url, data: body);
      // Handle the response as necessary
      print('Login Successful: ${response.data}');
    } catch (e) {
      // Handle errors or exceptions
      print('Error occurred: $e');
    }
  }
}
