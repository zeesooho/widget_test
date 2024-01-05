import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_test/common/helper_style.dart';
import 'package:widget_test/common/input_validation.dart';
import 'package:widget_test/login/singup_form.dart';

import 'id_pw_field.dart';

class SignUpWidget extends StatefulWidget {
  final String id;
  final String pw;
  final Function(SignUpForm signUpForm) onSignUp;

  const SignUpWidget({
    super.key,
    required this.id,
    required this.pw,
    required this.onSignUp,
  });

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwCheckController = TextEditingController();

  String _idHelperText = "이메일 인증에 사용되는 아이디입니다";
  String _pwHelperText = "숫자, 문자를 포함하여 8글자 이상 입력해주세요";
  String _pwCheckHelperText = "위와 동일하게 입력해주세요";

  HelperStyle _idHelperStyle = HelperStyle(state: HelperState.normal);
  HelperStyle _pwHelperStyle = HelperStyle(state: HelperState.normal);
  HelperStyle _pwCheckHelperStyle = HelperStyle(state: HelperState.normal);

  final _pwCheckStreamController = StreamController<String>();

  bool isValid = false;
  bool idValid = false;
  bool pwValid = false;
  bool pwCheckValid = false;
  bool nameValid = false;
  bool ageValid = false;
  bool genderValid = false;

  @override
  void initState() {
    super.initState();

    _idController.text = widget.id;
    _pwController.text = widget.pw;

    idValidate(widget.id);
    pwValidate(widget.pw);

    _pwCheckController.addListener(() {
      _pwCheckStreamController.sink.add(_pwCheckController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IdPwField(
            hintText: "dongajul@dongajul.com",
            labelText: "아이디",
            helperText: _idHelperText,
            helperStyle: _idHelperStyle,
            onChange: (id) => setState(() => idValidate(id)),
            onClear: () => setState(() => idValidate(_idController.text)),
            controller: _idController,
          ),
          IdPwField(
            labelText: "비밀번호",
            helperText: _pwHelperText,
            helperStyle: _pwHelperStyle,
            isPw: true,
            onChange: (pw) => setState(() => pwValidate(pw)),
            onClear: () => setState(() => pwValidate(_pwController.text)),
            controller: _pwController,
          ),
          IdPwField(
            labelText: "비밀번호 확인",
            helperText: _pwCheckHelperText,
            helperStyle: _pwCheckHelperStyle,
            isPw: true,
            onChange: (pwCheck) => setState(() => pwCheckValidate(pwCheck)),
            onClear: () => setState(() => pwCheckValidate(_pwCheckController.text)),
            controller: _pwCheckController,
          ),
          // BirthWidget(),
          StreamBuilder<bool>(
            stream: null,
            builder: (context, snapshot) {
              return SignUpButton(onPressed: (idValid && pwValid && pwCheckValid) ? signUp : null);
            },
          ),
        ],
      ),
    );
  }

  // 회원가입 버튼 눌렀을 시
  void signUp() {
    // form 검증 로직
    setState(() {});
    widget.onSignUp(SignUpForm());
  }

  // id 검증
  void idValidate(String id) {
    if (id.isValidEmailFormat()) {
      _idHelperText = "올바른 형식입니다";
      _idHelperStyle = HelperStyle(state: HelperState.correct);
      idValid = true;
    } else if (id.isEmpty) {
      _idHelperText = "이메일 인증에 사용되는 아이디입니다";
      _idHelperStyle = HelperStyle(state: HelperState.normal);
      idValid = false;
    } else {
      _idHelperText = "이메일 형식으로 입력해주세요";
      _idHelperStyle = HelperStyle(state: HelperState.error);
      idValid = false;
    }
  }

  // pw 검증
  void pwValidate(String pw) {
    if (pw.isValidPwFormat()) {
      _pwHelperText = "올바른 형식입니다";
      _pwHelperStyle = HelperStyle(state: HelperState.correct);
      pwValid = true;
    } else if (pw.isEmpty) {
      _pwHelperText = "숫자, 문자를 포함하여 8글자 이상 입력해주세요";
      _pwHelperStyle = HelperStyle(state: HelperState.normal);
    } else {
      _pwHelperText = "숫자, 문자를 포함하여 8글자 이상 입력해주세요";
      _pwHelperStyle = HelperStyle(state: HelperState.error);
      pwValid = false;
    }
  }

  // pwCheck 검증
  void pwCheckValidate(String pwCheck) {
    if (pwValid && pwCheck == _pwController.text) {
      _pwCheckHelperText = "확인되었습니다";
      _pwCheckHelperStyle = HelperStyle(state: HelperState.correct);
      pwCheckValid = true;
    } else if (pwCheck.isEmpty) {
      _pwCheckHelperText = "위와 동일하게 입력해주세요";
      _pwCheckHelperStyle = HelperStyle(state: HelperState.normal);
      pwCheckValid = false;
    } else if (_pwController.text.isNotEmpty && !pwValid) {
      _pwCheckHelperText = "비밀번호 형식이 맞지 않습니다";
      _pwCheckHelperStyle = HelperStyle(state: HelperState.error);
      pwCheckValid = false;
    } else {
      _pwCheckHelperText = "위와 동일하게 입력해주세요";
      _pwCheckHelperStyle = HelperStyle(state: HelperState.error);
      pwCheckValid = false;
    }
  }
}

class AgeWidget extends StatelessWidget {
  const AgeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("생년"), Text("월"), Text("일")],
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(18),
            backgroundColor: const Color.fromARGB(0xFF, 0xE9, 0xCE, 0xB7),
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
