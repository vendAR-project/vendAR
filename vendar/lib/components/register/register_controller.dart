import 'package:dio/dio.dart';

class RegisterController {
  Dio dio = Dio();
  Future<void> register(
      String name, String surname, String email, String password) async {
    final String url =
        "http://54.93.83.196:8080/register"; // TODO: keep such urls in a file named constants.dart then fetch it here for encapsulation
    final Map<String, dynamic> body = {
      "user_name": name,
      "user_surname": surname,
      "user_password": password,
      "user_email": email,
      "user_phone": "5448242002",
      "user_role": "USER"
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
