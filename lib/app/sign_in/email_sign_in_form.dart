import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_tut/app/sign_in/validators.dart';
import 'package:time_tracker_tut/common_widgets/form_submit_button.dart';
import 'package:time_tracker_tut/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_tut/services/auth.dart';

enum EmailSignInFormType { signIn, register }

// Stateful Widget
class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

// Widget implementation
class _EmailSignInFormState extends State<EmailSignInForm> {
  // textfield controller
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  // FocusNode
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // get the value of textfield
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  // set form type as sign-in as default
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  // for set state before submit to check for errors
  bool _submitted = false;
  bool _isLoading = false;

  // method: SUBMIT
  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailandPassword(_email, _password);
      } else {
        await auth.createEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } on Exception catch (e) {
      showAlertDialog(context,
          title: 'Sign in failed',
          content: e.toString(),
          defaultActionText: 'OK');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // method: TOGGLE FORM TYPE
  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? _formType = EmailSignInFormType.register
          : _formType = EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  // Build children widget => list of widgets
  List<Widget> _buildChildren() {
    // set the button text and flat button text according to form type
    final _primaryText =
        _formType == EmailSignInFormType.signIn ? 'Sign in' : 'Create Account';
    final _secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register here'
        : 'Have an account? Sign in';

    // set boolean to enable or disable button according to validity of textfields
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    // return widget list
    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 20.0,
      ),
      FormSubmitButton(
        text: _primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      TextButton(
        onPressed: _isLoading ? _toggleFormType : null,
        child: Text(
          _secondaryText,
        ),
      )
    ];
  }

  void _emailEditingComplete() {
    final focusNode = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(focusNode);
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (password) => _updateState(),
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'email@example.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _buildChildren(),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

  _updateState() {
    setState(() {});
  }
}
