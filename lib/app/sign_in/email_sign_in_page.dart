import 'package:flutter/material.dart';
import 'package:my_app/app/sign_in/email_sign_in_form.dart';
import 'package:my_app/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage({@required this.auth});
  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        elevation: 2.9,
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                  child: EmailSignInForm(
                auth: auth,
              )))),
      backgroundColor: Colors.grey[200],
    );
  }
}
