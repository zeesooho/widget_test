import 'package:flutter/material.dart';
import 'package:widget_test/login/login_widget.dart';
import 'package:widget_test/profile/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DongAJul Widget Test',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("DongAJul Widget Test"),
        ),
        body: LoginWidget(
          signIn: (id, pw) => print("id: $id, pw: "),
          signUp: () => print("signUP"),
        ),
      ),
    );
  }
}
