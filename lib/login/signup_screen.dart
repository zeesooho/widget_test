import 'package:flutter/material.dart';

import 'package:widget_test/login/signup_widget.dart';

class SignUpScreen extends StatelessWidget {
  final String id;
  final String pw;

  const SignUpScreen({super.key, this.id = "", this.pw = ""});

  @override
  Widget build(BuildContext context) {
    var signupWidget = SignUpWidget(
      id: id,
      pw: pw,
      onSignUp: (signUpForm) async {
        if (context.mounted) Navigator.of(context).pop();
        return true;
      },
    );
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("회원가입"),
        actions: [signupWidget.action],
      ),
      body: signupWidget,
    );
  }
}
