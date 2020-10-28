import 'package:flutter/material.dart';
import 'package:my_app/app/sign_in/email_sign_in_page.dart';
import 'package:my_app/app/sign_in/sign_in_button.dart';
import 'package:my_app/app/sign_in/social_sign_in_button.dart';

import 'package:my_app/services/auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({@required this.auth});

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
    //sign in page show
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(auth: auth,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hall Booking App',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        elevation: 2.9,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        // color: Colors.blueGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 48.0,
            ),
            SocialSignInButton(
              assetName: 'images/google-logo.png',
              text: 'Sign In With Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: _signInWithGoogle,
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              text: 'Sign In With Email',
              textColor: Colors.white,
              color: Colors.teal[700],
              onPressed: () => _signInWithEmail(context),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Or',
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              text: 'Go Anonymous',
              textColor: Colors.black,
              color: Colors.lime[300],
              onPressed: _signInAnonymously,
            ),
          ],
        ));
  }
}
