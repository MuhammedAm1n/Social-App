import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/PresentaionLayer/Component/Themes/ToggleLogin_Register.dart';
import 'package:social/PresentaionLayer/Screens/Homepage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // User Logged in
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return const LogOrReg();
            }
// user is not logged in
          }),
    );
  }
}
