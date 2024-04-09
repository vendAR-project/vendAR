import 'package:flutter/material.dart';
import 'package:vendar/model/user.dart';
import 'package:vendar/model/product.dart';
import 'package:vendar/components/profile/profile_controller.dart';
import 'package:vendar/widgets/profile_item_card.dart';
import 'package:vendar/components/product-detail/product_detail_view.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController _profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _profileController.getUserAndModels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final User currentUser = snapshot.data!['user'];
            final List<Product> models = snapshot.data!['models'];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 40.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.account_circle,
                        size: 100.0,
                        color: Color.fromARGB(255, 50, 81, 165),
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
                              const Color.fromARGB(255, 50, 81, 165),
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
                  const SizedBox(height: 50.0),
                  const Text(
                    "My Models",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: models.length,
                      itemBuilder: (context, index) {
                        final model = models[index];
                        return ProfileItemCard(
                          imageUrl: model.imageUrl,
                          name: model.name,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailView(product: model),
                              ),
                            );
                          },
                        );
                      },
                    ),
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
