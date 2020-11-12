import 'package:flutter/foundation.dart';
import 'package:my_app/app/sign_in/validators.dart';
import 'package:my_app/services/auth.dart';

import 'email_sign_in_model.dart';

class EmailSignInChangeModel with EmailAndPasswordVaidators, ChangeNotifier {
  EmailSignInChangeModel(
      {@required this.auth,
      this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.submitted = false});

  final AuthBase auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (this.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(this.email, this.password);
      } else {
        await auth.createUserWithEmailAndPassword(this.email, this.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account Sign in';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  void updateWith(
      {String email,
      String password,
      EmailSignInFormType formType,
      bool isLoading,
      bool submitted}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }

  void toggleFormType(EmailSignInModel model) {
    updateWith(
      email: '',
      password: '',
      submitted: false,
      formType: this.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
      isLoading: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);
}
