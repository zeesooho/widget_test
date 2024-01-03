import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  var signUpForm = [];

  @override
  void initState() {
    super.initState();
    // 만약 회원가입 폼 불러와야할 시 여기서 불러옴
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("test??"),
          Text("test2"),
          Card(
            color: Color.fromARGB(0xFF, 0xF0, 0xF0, 0xF0),
            child: SizedBox(
              width: double.infinity,
              height: 400,
            ),
          ),
        ],
      ),
    );
  }
}
