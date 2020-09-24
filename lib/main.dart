import 'package:flutter/material.dart';
import 'package:my_app/app/landing_page.dart';
import 'package:my_app/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //return Container();
    return MaterialApp(
      title: 'Hall Booking',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: LandingPage(auth: Auth()),
    );
  }
}
