import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controllers/profil_controller.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD3A335),
        elevation: 0,
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          // Profile picture and info section
          Obx(() {
            return Container(
              color: Color(0xFFD3A335),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () => _showImagePickerOptions(context),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Center(
                        child: profileController.selectedImagePath.value.isEmpty
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.black,
                                child: Icon(Icons.person, size: 50, color: Colors.white),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(File(profileController.selectedImagePath.value)),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      Get.arguments['username'] ?? '',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      Get.arguments['email'] ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }),
          SizedBox(height: 24),

          // My Account section
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Account'),
            subtitle: Text('Edit your information'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Implement navigation to edit profile screen
            },
          ),
        ],
      ),
    );
  }

  // Function to show the image picker options
  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Select Image from Gallery'),
                onTap: () {
                  profileController.selectImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take Picture'),
                onTap: () {
                  profileController.takePicture();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete Photo'),
                onTap: () {
                  profileController.deletePhoto();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}