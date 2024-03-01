import 'package:flutter/material.dart';
import 'package:social/PresentaionLayer/Screens/LoginPage.dart';
import 'package:social/PresentaionLayer/Screens/RegisterPage.dart';

class LogOrReg extends StatefulWidget {
  const LogOrReg({super.key});

  @override
  State<LogOrReg> createState() => _LogOrRegState();
}

class _LogOrRegState extends State<LogOrReg> {
  bool showLoginPage = true;

  void Toggle() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: Toggle);
    } else {
      return RegisterPage(onTap: Toggle);
    }
  }
}
