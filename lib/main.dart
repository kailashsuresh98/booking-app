import 'package:flutter/material.dart';
import 'package:my_app/app/landing_page.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/services/auth_provider_del.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return Container();
    return Provider<AuthBase>(
        create: (context) => Auth(),
        child: MaterialApp(
          title: 'Hall Booking',
          theme: ThemeData(primarySwatch: Colors.indigo),
          home: LandingPage(),
        ));
  }
}
