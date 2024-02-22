import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wizardry_app/screens/add_post_screen.dart';
import 'package:wizardry_app/screens/user_profile_screen.dart';
import 'package:wizardry_app/screens/feed.dart';
const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const Feed(),
  const AddPostScreen(),
  const Text('Notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];