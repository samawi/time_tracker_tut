import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_tut/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_tut/services/auth.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignout = await showAlertDialog(
      context,
      title: 'Log out',
      content: 'Are you sure you want to logout?',
      defaultActionText: 'OK',
      cancelActionText: 'Cancel',
    );
    if (didRequestSignout) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
    );
  }
}
