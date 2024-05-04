import 'package:flutter/material.dart';
import 'package:vendar/model/user.dart';
import 'package:vendar/model/product.dart';
import 'package:vendar/components/profile/profile_controller.dart';
import 'package:vendar/widgets/profile_item_card.dart';
import 'package:vendar/components/product-detail/product_detail_view.dart';
import 'package:vendar/components/login/login_view.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController _profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Do you want to logout?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          // Then navigate to the login screen or handle the logout logic
                          Navigator.pushReplacement(
                            // Use pushReplacement to replace the navigation stack
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()),
                          );
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
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
                  Row(
                    children: [
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${currentUser.name} ${currentUser.surname}',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Divider(thickness: 2.0, color: Colors.deepPurple),
                  _buildInfoTile('Phone Number', currentUser.phoneNumber),
                  Divider(thickness: 2.0, color: Colors.deepPurple),
                  _buildInfoTile('E-Mail', currentUser.email),
                  Divider(thickness: 2.0, color: Colors.deepPurple),
                  const SizedBox(height: 20.0),
                  _buildButtonRow(context),
                  const SizedBox(height: 50.0),
                  Text(
                    "My Models",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor),
                  ),
                  const SizedBox(height: 20.0),
                  _buildModelsList(models, context),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  ListTile _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value, style: const TextStyle(color: Colors.grey)),
    );
  }

  Row _buildButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(150, 50),
          ),
          child: const Text('Change Email'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(150, 50),
          ),
          child: const Text('Change Password'),
        ),
      ],
    );
  }

  SizedBox _buildModelsList(List<Product> models, BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: models.length,
        itemBuilder: (context, index) {
          final Product model = models[index];
          return ProfileItemCard(
            imageUrl: model.imageUrls[0],
            name: model.name,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailView(product: model),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
