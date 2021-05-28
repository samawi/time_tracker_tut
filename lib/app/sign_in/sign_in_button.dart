import 'package:flutter/material.dart';
import 'package:time_tracker_tut/common_widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    required String text,
    Color color: Colors.white,
    Color textColor: Colors.black87,
    required VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          height: 40.0,
          color: color,
          onPressed: onPressed,
        );
}
