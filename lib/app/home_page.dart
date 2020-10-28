import 'package:flutter/material.dart';
import 'package:my_app/common_widgets/platform_alert_dialog.dart';
import 'package:my_app/services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({
    @required this.auth,
  });

  final AuthBase auth;
  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home Page'), actions: <Widget>[
      FlatButton(
        child: Text('logout',
            style: TextStyle(fontSize: 18.0, color: Colors.white)),
        onPressed: () => _confirmSignOut(context),
      )
    ]));
  }
}
