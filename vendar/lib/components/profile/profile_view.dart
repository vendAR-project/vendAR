import 'package:flutter/material.dart';
import 'package:vendar/model/user.dart';
import 'package:vendar/components/profile/profile_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController _profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: _profileController.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is loading
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there's an error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // If data is successfully loaded
            final User? currentUser = snapshot.data;
            if (currentUser == null) {
              return const Center(child: Text('No user data available'));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.account_circle,
                        size: 100.0,
                        color: Color.fromARGB(255, 18, 63, 187),
                      ),
                      const SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentUser.name,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            currentUser.email,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Divider(thickness: 1.0, color: Colors.grey),
                  ListTile(
                    title: const Text('Name'),
                    subtitle: Text(
                      currentUser.name,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Divider(thickness: 1.0, color: Colors.grey),
                  ListTile(
                    title: const Text('Surname'),
                    subtitle: Text(
                      currentUser.surname,
                      style: const TextStyle(color: Colors.grey),
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
                          backgroundColor:
                              const Color.fromARGB(255, 18, 63, 187),
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
                          backgroundColor:
                              const Color.fromARGB(255, 50, 81, 165),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(150, 50),
                        ),
                        child: const Text('Change Password'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
