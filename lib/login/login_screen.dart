import 'package:flutter/material.dart';
import 'package:widget_test/login/login_widget.dart';
import 'package:widget_test/login/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("DongAJul Widget Test"),
      ),
      body: Center(
        child: LoginWidget(
          signIn: (id, pw) {
            return id != pw;
          },
          signUp: (id, pw) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(id: id, pw: pw),
              ),
            );
          },
          onForgotPw: () => {},
        ),
      ),
    );
  }
}
