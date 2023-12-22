import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/pages/home_page.dart';
import '/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          //User is logged in
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage();
          }
          //User is not logged in
        }),
      ),
    );
  }
}
