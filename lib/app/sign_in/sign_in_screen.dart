import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_tut/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_tut/app/sign_in/social_sign_in_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key, required this.onSignIn}) : super(key: key);

  final void Function(User) onSignIn;

  Future<void> _signInAnonymously() async {
    try {
      // print('Signing in anonymously...');
      final userCredentials = await FirebaseAuth.instance.signInAnonymously();
      onSignIn(userCredentials.user!);
      // print('${userCredentials.user!.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: createContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget createContents() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in with Google',
            onPressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            onPressed: () {},
            textColor: Colors.white,
            color: Color(0xFF334D92),
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Sign in with Email',
            onPressed: () {},
            textColor: Colors.white,
            color: Colors.teal.shade700,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Go anonymous',
            onPressed: _signInAnonymously,
            textColor: Colors.black,
            color: Colors.lime.shade300,
          ),
        ],
      ),
    );
  }
}
