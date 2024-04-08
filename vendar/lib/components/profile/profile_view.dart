import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            const Row(
              children: [
                Icon(
                  Icons.account_circle,
                  size: 100.0,
                  color: Color.fromARGB(255, 18, 63, 187),
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'johndoe@example.com',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Divider(thickness: 1.0, color: Colors.grey),
            const ListTile(
              title: Text('Name'),
              subtitle: Text(
                'John Doe',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const Divider(thickness: 1.0, color: Colors.grey),
            const ListTile(
              title: Text('Surname'),
              subtitle: Text(
                'Smith',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const Divider(thickness: 1.0, color: Colors.grey),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: const Color.fromARGB(255, 18, 63, 187),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text('Change Email'),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: const Color.fromARGB(255, 50, 81, 165),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text('Change Password'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
