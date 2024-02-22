import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wizardry_app/responsive/mobile_layout.dart';
import 'package:wizardry_app/responsive/responsive_layout_screen.dart';
import 'package:wizardry_app/responsive/web_layout.dart';
import 'package:wizardry_app/screens/login_screen.dart';
import 'package:wizardry_app/widgets/text_fields.dart';
import 'package:wizardry_app/resources/auth_methods.dart';
import 'package:wizardry_app/utilities/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  Uint8List? image;

  bool loading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    bioController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List imageList = await pickImage(ImageSource.gallery);
    setState(() {
      image = imageList;
    });
  }

  void registerUser() async {
    setState(() {
      loading = true;
    });
    String result = await AuthMethods().registerUser(
      email: emailController.text,
      password: passwordController.text,
      username: usernameController.text,
      bio: bioController.text,
      file: image!,
    );
    if (result == 'User registered successfully') {
      setState(() {
        loading = false;
      });
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayoutScreen(
              mobilescreen: MobileScreenLayout(),
              webscreen: WebScreenLayout(),
            ),
          ),
        );
      }
    }
    //showSnackBar(context, result);
    if (result != 'User registered successfully') {
      showSnackBar(context, result);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(child: Container(), flex: 2),
                    // logo
                    SvgPicture.asset('assets/logo.svg',
                        height: 50, width: 50, color: Colors.white),
                    const SizedBox(height: 64),
                    Stack(
                      children: [
                        image != null
                            ? CircleAvatar(
                                radius: 50,
                                //backgroundColor: Colors.blue,
                                backgroundImage: MemoryImage(image!),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.blue,
                                child: const Icon(Icons.person, size: 50),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 60,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add_a_photo)),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFieldInput(
                      hintText: 'Username',
                      inputType: TextInputType.text,
                      textEditingController: usernameController,
                    ),
                    const SizedBox(height: 16),
                    // email
                    TextFieldInput(
                      hintText: 'Email',
                      inputType: TextInputType.emailAddress,
                      textEditingController: emailController,
                    ),
                    const SizedBox(height: 16),
                    // password
                    TextFieldInput(
                      hintText: 'Password',
                      inputType: TextInputType.visiblePassword,
                      textEditingController: passwordController,
                      password: true,
                    ),
                    const SizedBox(height: 16),
                    // confirm password
                    TextFieldInput(
                      hintText: 'Confirm Password',
                      inputType: TextInputType.visiblePassword,
                      textEditingController: confirmPasswordController,
                      password: true,
                    ),
                    const SizedBox(height: 16),
                    TextFieldInput(
                      hintText: 'Bio',
                      inputType: TextInputType.text,
                      textEditingController: bioController,
                    ),
                    const SizedBox(height: 16),
                    // login button
                    InkWell(
                      onTap: registerUser,
                      child: Container(
                        child: loading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Register',
                                style: TextStyle(color: Colors.white)),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Flexible(child: Container(), flex: 2),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: const Text('Have an account?\t'),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text('Login here',
                                style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),  
                          ),
                        ),
                        )
                      ],
                    )
                  ],
                ))));
  }
}
