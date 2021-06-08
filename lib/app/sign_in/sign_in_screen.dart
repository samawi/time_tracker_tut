import 'package:flutter/material.dart';
import 'package:time_tracker_tut/app/sign_in/email_sign_in_screen.dart';
import 'package:time_tracker_tut/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_tut/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_tut/services/auth.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EmailSignInScreen(
        auth: auth,
      ),
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: createContents(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget createContents(BuildContext context) {
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
            onPressed: _signInWithGoogle,
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
            onPressed: () => _signInWithEmail(context),
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
