import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_tut/app/home_page.dart';
import 'package:time_tracker_tut/app/sign_in/sign_in_screen.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      _updateUser(FirebaseAuth.instance.currentUser);
    }
  }

  void _updateUser(User? user) {
    // print('User id: ${user.uid}');
    setState(() {
      _user = user;
    });
  }

  void _updateUser2() {
    setState(() {
      _user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInScreen(
        onSignIn: _updateUser,
      );
    }
    return HomePage(
      onSignOut: () => {_updateUser2()},
    );
  }
}
