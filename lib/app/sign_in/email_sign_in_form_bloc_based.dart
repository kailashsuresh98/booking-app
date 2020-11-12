import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/app/sign_in/email_sign_in_bloc.dart';
import 'package:my_app/app/sign_in/validators.dart';
import 'package:my_app/common_widgets/form_submit_button.dart';
import 'package:my_app/common_widgets/platform_alert_dialog.dart';
import 'package:my_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:my_app/services/auth.dart';
import 'package:provider/provider.dart';

import 'email_sign_in_model.dart';

class EmailSignInFormBlocBased extends StatefulWidget {
  EmailSignInFormBlocBased({@required this.bloc});
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return Provider<EmailSignInBloc>(
      create: (context) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
          builder: (context, bloc, _) => EmailSignInFormBlocBased(bloc: bloc)),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // String get _email => _emailController.text;
  // String get _password => _passwordController.text;
  // EmailSignInFormType _formType = EmailSignInFormType.signIn;
  // bool _submitted = false;
  // bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign In Failed',
        exception: e,
      ).show(context);
    }
  }

  void _toggleFormType(EmailSignInModel model) {
    widget.bloc.updateWith(
      email: '',
      password: '',
      submitted: false,
      formType: model.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
      isLoading: false,
    );
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    // final primaryText = model.formType == EmailSignInFormType.signIn
    //     ? 'Sign In'
    //     : 'Create an account';
    // final secondaryText = model.formType == EmailSignInFormType.signIn
    //     ? 'Need an account? Register'
    //     : 'Have an account Sign in';

    // bool submitEnabled = model.emailValidator.isValid(model.email) &&
    //     model.passwordValidator.isValid(model.password) &&
    //     !model.isLoading;

    return [
      _buildEmailTextField(model),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(model),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        child: Text(model.secondaryButtonText),
        onPressed: !model.isLoading ? () => _toggleFormType(model) : null,
      )
    ];
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    bool showErrorText =
        model.submitted && model.emailValidator.isValid(model.email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter Your Email',
        errorText: showErrorText ? model.invalidEmailErrorText : null,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => widget.bloc.updateWith(email: email),
      onEditingComplete: () => _emailEditingComplete(model),
    );
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    bool showErrorText =
        model.submitted && model.passwordValidator.isValid(model.password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? model.invalidPasswordErrorText : null,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (password) => widget.bloc.updateWith(password: password),
      onEditingComplete: _submit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildChildren(model),
              ));
        });
  }
}
