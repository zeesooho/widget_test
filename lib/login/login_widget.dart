import 'package:flutter/material.dart';
import 'package:widget_test/common/input_validation.dart';

import 'package:widget_test/common/helper_style.dart';
import 'id_pw_field.dart';

class LoginWidget extends StatefulWidget {
  final Future<bool> Function(String, String) signIn;
  final Function(String, String) signUp;
  final Function() onForgotPw;

  const LoginWidget({
    super.key,
    required this.signIn,
    required this.signUp,
    required this.onForgotPw,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  String? _idHelperText;
  String? _pwHelperText;

  HelperStyle? _idHelperStyle;
  HelperStyle? _pwHelperStyle;

  bool tried = false;
  bool idValid = false;
  bool pwValid = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IdPwField(
              padding: const EdgeInsets.symmetric(vertical: 8),
              hintText: "dongajul@dongajul.com",
              labelText: "아이디",
              helperText: _idHelperText,
              helperStyle: _idHelperStyle,
              onChange: (id) => setState(() => idValidate(id)),
              onClear: () => setState(() => idValidate(_idController.text)),
              controller: _idController,
            ),
            IdPwField(
              padding: const EdgeInsets.symmetric(vertical: 8),
              labelText: "비밀번호",
              helperText: _pwHelperText,
              helperStyle: _pwHelperStyle,
              isPw: true,
              onChange: (pw) => setState(() => pwValidate(pw)),
              onClear: () => setState(() => pwValidate(_pwController.text)),
              controller: _pwController,
            ),
            ForgotPassword(
              visibility: tried,
              onPressed: widget.onForgotPw,
            ),
            SignInButton(onPressed: idValid && pwValid ? signIn : null),
            SignUpButton(onPressed: signUp),
          ],
        ),
      ),
    );
  }

  void pwValidate(String pw) {
    if (pw.isValidPwFormat()) {
      _pwHelperText = null;
      pwValid = true;
    } else {
      _pwHelperText = "숫자, 문자를 포함하여 8글자 이상 입력해주세요";
      _pwHelperStyle = HelperStyle(state: HelperState.error);
      pwValid = false;
    }
  }

  void idValidate(String id) {
    if (id.isValidEmailFormat()) {
      _idHelperText = null;
      idValid = true;
    } else {
      _idHelperText = "이메일 형식으로 입력해주세요";
      _idHelperStyle = HelperStyle(state: HelperState.error);
      idValid = false;
    }
  }

  void signIn() async {
    tried = !await widget.signIn(_idController.text, _pwController.text);
    _pwHelperStyle = HelperStyle(state: HelperState.error);
    setState(() => {});
  }

  void signUp() => setState(() => widget.signUp(_idController.text, _pwController.text));
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
    required this.onPressed,
    required this.visibility,
  });

  final Function() onPressed;
  final bool visibility;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextButton(
          onPressed: onPressed,
          child: const Text(
            "비밀번호를 잊었나요?",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            backgroundColor: const Color.fromARGB(0xFF, 0xE9, 0xCE, 0xB7),
          ),
          child: const Text(
            "로그인",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: const BorderSide(
              color: Color.fromARGB(0xFF, 0xE9, 0xCE, 0xB7),
            ),
          ),
          child: const Text(
            "회원가입",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
