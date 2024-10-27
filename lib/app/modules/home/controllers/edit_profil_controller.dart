import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controllers/auth_controller.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  final TextEditingController  _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  EditProfilePage() {
    // Initialize with current profile data
    _nameController.text = _authController.userProfile['name'] ?? '';
    _usernameController.text = _authController.userProfile['username'] ?? '';
    _emailController.text = _authController.userProfile['email'] ?? '';
    _ageController.text = _authController.userProfile['age']?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Obx(() {
              return _authController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        final name = _nameController.text;
                        final username = _usernameController.text;
                        final email = _emailController.text;
                        final age = int.tryParse(_ageController.text) ?? 0;

                        // Validate input
                        if (name.isEmpty || username.isEmpty || email.isEmpty || age<= 0) {
                          Get.snackbar('Error', 'Name, Username and Email are required. Age could not',
                              backgroundColor: Colors.red);
                          return;
                        }

                        await _authController.updateUserProfile(name, username, email, age);
                        Get.snackbar('Success', 'Profile updated successfully',
                            backgroundColor: Colors.green);
                        Get.back(); // Go back to ProfilePage
                      },
                      child: Text('Save Changes'),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
