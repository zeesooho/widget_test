import 'package:flutter/material.dart';
import 'package:widget_test/login/login_screen.dart';

import 'login/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DongAJul Widget Test',
      home: SignUpScreen(),
    );
  }
}
