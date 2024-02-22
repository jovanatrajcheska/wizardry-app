import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wizardry_app/resources/storage_methods.dart';
import 'dart:typed_data';
import 'package:wizardry_app/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }
  // register user
  Future<String> registerUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String result = 'An error occurred';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // register the user
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(credentials.user!.uid);

        String photoUrl =
            await StorageMethods().uploadImage('profile_pictures', file, false);

        await _firestore.collection('users').add({
          'email': email,
          'username': username,
          'bio': bio,
          'uid': credentials.user!.uid,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });
        result = 'User registered successfully';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        result = 'Invalid email';
      } else if (e.code == 'email-already-in-use') {
        result = 'Email already in use';
      } else if (e.code == 'weak-password') {
        result = 'Weak password';
      }
      result = e.message!;
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  // login user
  Future<String> loginUser({required String email, required String password}) async {
    String result = 'An error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        result = 'User logged in successfully';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        result = 'Invalid email';
      } else if (e.code == 'user-not-found') {
        result = 'User not found';
      } else if (e.code == 'wrong-password') {
        result = 'Wrong password';
      }
      result = e.message!;
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
