import 'package:flutter/material.dart';
import 'package:vendar/components/login/login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100.0),
            const SizedBox(
              height: 80.0,
              child: Center(
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            const Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Surname',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            const SizedBox(
              height: 50.0,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10.0),

            const SizedBox(
              height: 50.0,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 10.0),

            const SizedBox(
              height: 50.0,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Retype Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20.0),

            // Register button with spacing
            SizedBox(
              height: 75.0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  ),
                  child: const Text('Register'),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              height: 50.0,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                    );
                  },
                  child: const Text('Go back to Login Screen'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
