import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/app/modules/home/views/login_view.dart';
import 'package:flutter_application_1/app/modules/home/views/store_view.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  RxMap<String, dynamic> userProfile = <String, dynamic>{}.obs;

  // Login function
  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userData = await _firestore.collection('users').doc(user.uid).get();
        userProfile.value = userData.data() as Map<String, dynamic>;
      }

      Get.snackbar('Success', 'Login successful', backgroundColor: Colors.green);
      Get.offAll(() => StorePage());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Login failed: ${e.message}', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Register function
  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': 'none',
          'username': 'none',
          'email': email,
          'age': 0,
        });
        Get.snackbar('Success', 'Registration successful', backgroundColor: Colors.green);
        Get.offAll(() => LoginPage());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Registration failed: ${e.message}', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch user profile data
  Future<void> fetchUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        userProfile.value = userDoc.data() as Map<String, dynamic>;
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to load profile data: $error', backgroundColor: Colors.red);
    }
  }

  Future<void> updateUserProfile(String name, String username, String email, int age) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': name,
          'username': username,
          'email': email,
          'age': age,
        });
        userProfile['name'] = name;
        userProfile['username'] = username;
        userProfile['email'] = email;
        userProfile['age'] = age;
        Get.snackbar('Success', 'Profile updated successfully', backgroundColor: Colors.green);
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to update profile: $error', backgroundColor: Colors.red);
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(() => LoginPage());
  }

  // Get current user
  User? get currentUser => _auth.currentUser;
}
