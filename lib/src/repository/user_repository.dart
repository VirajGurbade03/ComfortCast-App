import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comfortcast_1/src/fetures/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find<UserRepository>();

  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUser(UserModel user) async {
    try {
      User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        await _db
            .collection("Users")
            .doc(firebaseUser.uid)
            .set(user.tojson(), SetOptions(merge: true));
        Get.snackbar(
          "Success",
          "Your account has been created",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.2),
          colorText: Colors.green,
        );
      } else {
        throw Exception("No authenticated user found.");
      }
    } catch (error) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again. Error: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red,
      );
    }
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, Function(String) codeSent) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar(
            "Error",
            "Verification failed: ${e.message}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: Colors.red,
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          codeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (error) {
      Get.snackbar(
        "Error",
        "Phone verification failed. Please try again. Error: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red,
      );
    }
  }

  Future<void> signInWithOtp(
      String verificationId, String otp, UserModel user) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        await createUser(user);
      }
    } catch (error) {
      Get.snackbar(
        "Error",
        "OTP verification failed. Please try again. Error: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red,
      );
    }
  }

  Future<void> signUpWithEmail(
      String email, String password, UserModel user) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      user.id = userCredential.user!.uid; // Set the ID from Firebase Auth
      await createUser(user);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        "Email sign-up failed: ${e.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red,
      );
    } catch (error) {
      Get.snackbar(
        "Error",
        "An unexpected error occurred during sign-up. Error: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red,
      );
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        "Email sign-in failed: ${e.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red,
      );
    } catch (error) {
      Get.snackbar(
        "Error",
        "An unexpected error occurred during sign-in. Error: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red,
      );
    }
  }
}
