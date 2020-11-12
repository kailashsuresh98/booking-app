import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:my_app/app/sign_in/email_sign_in_model.dart';
import 'package:my_app/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

    void toggleFormType(EmailSignInModel model) {
    updateWith(
      email: '',
      password: '',
      submitted: false,
      formType: _model.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
      isLoading: false,
    );

  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  void updateWith(
      {final String email,
      final String password,
      final EmailSignInFormType formType,
      final bool isLoading,
      final bool submitted}) {
    _model = _model.copyWith(
        email: email,
        password: password,
        formType: formType,
        isLoading: isLoading,
        submitted: submitted);
    _modelController.add(_model);
  }
}
