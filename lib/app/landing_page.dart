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
    // listen to authStateChanges stream and rebuilt widget whenever there's
    // an event in the stream
    // Note: stream type is type User
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        print('In StreamBuilder');
        if (snapshot.connectionState == ConnectionState.active) {
          print('ConnectionState is active');
          // if stream is giving data
          final User? user = snapshot.data;
          if (user == null) {
            print('user is null');
            // if user is null, leave this screen and go to SignInScreen
            return SignInScreen(
              auth: auth,
            );
          }
          // otherwise (if user is logged in), leave this screen and go to HomePage
          print('user is logged in');
          return HomePage(
            auth: auth,
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          print('ConnectionState is waiting');
        } else if (snapshot.connectionState == ConnectionState.done) {
          print('ConnectionState is done');
        } else if (snapshot.connectionState == ConnectionState.none) {
          print('ConnectionState is none');
        }
        // in any other condition than Active, then show progress indicator
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
