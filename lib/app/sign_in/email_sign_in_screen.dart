import 'package:flutter/material.dart';
import 'package:time_tracker_tut/app/sign_in/email_sign_in_form.dart';
import 'package:time_tracker_tut/services/auth.dart';

class EmailSignInScreen extends StatelessWidget {
  const EmailSignInScreen({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: EmailSignInForm(
            auth: auth,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
