import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wizardry_app/responsive/mobile_layout.dart';
import 'package:wizardry_app/responsive/responsive_layout_screen.dart';
import 'package:wizardry_app/responsive/web_layout.dart';
import 'package:wizardry_app/screens/login_screen.dart';
import 'package:wizardry_app/utilities/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wizardry_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        name: 'wizardry-641e8',
        options: const FirebaseOptions(
            apiKey: "AIzaSyCWaJkdMxtlORJXkfkR2iU18nBTHHI1L3Y",
            authDomain: "wizardry-641e8.firebaseapp.com",
            projectId: "wizardry-641e8",
            storageBucket: "wizardry-641e8.appspot.com",
            messagingSenderId: "819035409014",
            appId: "1:819035409014:web:434f8ef1ef0c6ed6dced57"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

Future<DocumentSnapshot> getUserDetails() async {
  return await FirebaseFirestore.instance
      .collection('users')
      .doc('user1')
      .get();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'wizardry - book review app',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayoutScreen(
                  mobilescreen: MobileScreenLayout(),
                  webscreen: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
