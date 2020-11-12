import 'package:flutter/material.dart';
import 'package:my_app/services/auth.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({@required this.auth, @required this.child});
  final AuthBase auth;
  final Widget child;
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }

  static AuthBase of(BuildContext context) {
    AuthProvider provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider.auth;
  }
}
