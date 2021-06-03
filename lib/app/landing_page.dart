import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_tut/app/home_page.dart';
import 'package:time_tracker_tut/app/sign_in/sign_in_screen.dart';
import 'package:time_tracker_tut/services/auth.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshop) {
        if (snapshop.connectionState == ConnectionState.active) {
          final User? user = snapshop.data;
          if (user == null) {
            return SignInScreen(
              auth: auth,
            );
          }
          return HomePage(
            auth: auth,
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
