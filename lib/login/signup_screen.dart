import 'package:flutter/material.dart';
import 'package:widget_test/login/signup_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("회원가입"),
      ),
      body: const SignUpWidget(),
    );
  }
}
