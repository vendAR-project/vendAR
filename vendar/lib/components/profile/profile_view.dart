import 'package:flutter/material.dart';
import 'package:vendar/model/user.dart';
import 'package:vendar/model/product.dart';
import 'package:vendar/components/profile/profile_controller.dart';
import 'package:vendar/widgets/profile_item_card.dart';
import 'package:vendar/components/product-detail/product_detail_view.dart';
import 'package:vendar/components/login/login_view.dart';
import 'package:vendar/components/modify-model/modify_model_view.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController _profileController = ProfileController();

  Future<Map<String, dynamic>>? _userAndModels;

  @override
  void initState() {
    super.initState();
    _userAndModels = _profileController.getUserAndModels();
  }

  Future<void> _refreshProfile() async {
    setState(() {
      _userAndModels = _profileController.getUserAndModels();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.red),
            onPressed: () => _confirmLogout(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProfile,
        child: FutureBuilder<Map<String, dynamic>>(
          future: _userAndModels,
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${currentUser.name} ${currentUser.surname}',
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: theme.primaryColor)),
                              const SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Divider(thickness: 2.0, color: theme.primaryColor),
                    _buildInfoTile(
                        context,
                        'Phone Number',
                        currentUser.phoneNumber,
                        Icons.edit,
                        _changePhoneNumber),
                    Divider(thickness: 2.0, color: theme.primaryColor),
                    _buildInfoTile(context, 'E-Mail', currentUser.email,
                        Icons.edit, _changeEmail),
                    Divider(thickness: 2.0, color: theme.primaryColor),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () => _changePassword(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50),
                        backgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Change Password'),
                    ),
                    const SizedBox(height: 50.0),
                    Text("My Models",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor)),
                    const SizedBox(height: 20.0),
                    _buildModelsList(models, context),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  ListTile _buildInfoTile(BuildContext context, String title, String value,
      IconData icon, Function(String) changeFunction) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value, style: const TextStyle(color: Colors.grey)),
      trailing: IconButton(
        icon: Icon(icon, color: Theme.of(context).primaryColor),
        onPressed: () => _showEditDialog(context, title, value, changeFunction),
      ),
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
                  builder: (context) => ModifyModelView(product: model),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Do you want to logout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, String title, String currentValue,
      Function(String) changeFunction) {
    TextEditingController _controller =
        TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change $title"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: "New $title"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (_controller.text.isNotEmpty) {
                  Navigator.of(context).pop(); // Close the dialog
                  await changeFunction(_controller.text);
                  _refreshProfile(); // Refresh after successful update
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changePhoneNumber(String newPhoneNumber) async {
    await _profileController.changePhoneNumber(newPhoneNumber);
    _refreshProfile();
  }

  Future<void> _changeEmail(String newEmail) async {
    await _profileController.changeEmail(newEmail);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }

  void _changePassword(BuildContext context) {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController retypeNewPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Change Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: currentPasswordController,
                decoration:
                    const InputDecoration(labelText: "Current Password"),
                obscureText: true,
              ),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(labelText: "New Password"),
                obscureText: true,
              ),
              TextField(
                controller: retypeNewPasswordController,
                decoration:
                    const InputDecoration(labelText: "Retype New Password"),
                obscureText: true,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (newPasswordController.text.isNotEmpty &&
                    newPasswordController.text ==
                        retypeNewPasswordController.text) {
                  await _profileController.changePassword(
                      newPasswordController.text,
                      currentPasswordController.text);
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                }
              },
              child: const Text("Change"),
            ),
          ],
        );
      },
    );
  }
}
