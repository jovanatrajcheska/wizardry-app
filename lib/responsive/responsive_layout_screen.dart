import 'package:flutter/material.dart';
import 'package:wizardry_app/utilities/variables.dart';
import 'package:provider/provider.dart';
import 'package:wizardry_app/providers/user_provider.dart';

class ResponsiveLayoutScreen extends StatefulWidget {
  final Widget mobilescreen;
  final Widget webscreen;
  const ResponsiveLayoutScreen({
    Key? key,
    required this.mobilescreen,
    required this.webscreen,
  }) : super(key: key);

  @override
  State<ResponsiveLayoutScreen> createState() => _ResponsiveLayoutScreenState();
}

class _ResponsiveLayoutScreenState extends State<ResponsiveLayoutScreen> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return widget.webscreen;
      }
      return widget.mobilescreen;
    });
  }
}
