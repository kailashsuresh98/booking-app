import 'package:flutter/material.dart';
import 'package:my_app/app/home/jobs_page.dart';
import 'package:my_app/app/sign_in/sign_in_pages.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/services/auth_provider_del.dart';
import 'package:my_app/services/database.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SignInPage.create(context);
            }
            return Provider<Database>(
                create: (_) => FireStoreDatabase(uid: user.uid),
                child: JobsPage());
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
