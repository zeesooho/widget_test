import 'dart:async';

import 'package:flutter/material.dart';

import 'package:widget_test/common/common_text_field.dart';
import 'package:widget_test/common/helper_style.dart';
import 'package:widget_test/common/input_validation.dart';
import 'package:widget_test/login/singup_form.dart';

import 'id_pw_field.dart';

class SignUpWidget extends StatefulWidget {
  final SignUpWidgetState signUpWidgetState = SignUpWidgetState();
  final String id;
  final String pw;
  final bool Function(String signUpForm) onSignUp;
  final StreamController<bool> vaildStreamController = StreamController();

  late final Widget action;

  SignUpWidget({
    super.key,
    required this.id,
    required this.pw,
    required this.onSignUp,
  }) {
    action = StreamBuilder<bool>(
        stream: vaildStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!) {
            return IconButton(
              icon: const Icon(Icons.done, color: Colors.blue),
              onPressed: () => signUpWidgetState.signUp(),
            );
          }
          return const IconButton(
            icon: Icon(Icons.done),
            onPressed: null,
          );
        });
  }

  @override
  State<SignUpWidget> createState() {
    // ignore: no_logic_in_create_state
    return signUpWidgetState;
  }
}

class SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwCheckController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String _idHelperText = "이메일 인증에 사용되는 아이디입니다";
  String _pwHelperText = "숫자, 문자를 포함하여 8글자 이상 입력해주세요";
  String _pwCheckHelperText = "위와 동일하게 입력해주세요";

  HelperStyle _idHelperStyle = HelperStyle(state: HelperState.normal);
  HelperStyle _pwHelperStyle = HelperStyle(state: HelperState.normal);
  HelperStyle _pwCheckHelperStyle = HelperStyle(state: HelperState.normal);

  final _pwCheckStreamController = StreamController<String>();

  get isValid => (idValid && pwValid && pwCheckValid && nameValid && ageValid && genderValid);
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
          Row(
            children: [
              Flexible(
                flex: 3,
                child: CommonTextField(
                  labelText: "이름",
                  edgeInsets: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  controller: _nameController,
                  onChange: (name) => setState(() => nameValidate(name)),
                  onClear: () => setState(() => nameValidate("")),
                ),
              ),
              Flexible(
                flex: 2,
                child: CommonTextField(
                  labelText: "성별",
                  edgeInsets: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  controller: _genderController,
                  onChange: (gender) => setState(() => genderValidate(gender)),
                  onClear: () => setState(() => genderValidate("")),
                ),
              ),
            ],
          ),
          CommonTextField(
            labelText: "생년월일",
            edgeInsets: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            controller: _ageController,
            isLast: true,
            onChange: (age) => setState(() => ageValidate(age)),
            onClear: () => setState(() => ageValidate("")),
          ),
        ],
      ),
    );
  }

  // 회원가입 버튼 눌렀을 시
  void signUp() {
    // form 검증 로직
    widget.onSignUp(
        "id: ${_idController.text}, pw: ${_pwController.text}, name: ${_nameController.text}, gender: ${_genderController.text}, age: ${_ageController.text}");
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
    validSink();
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
    validSink();
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
    validSink();
  }

  void ageValidate(String age) {
    ageValid = age.isNotEmpty;
    validSink();
  }

  void genderValidate(String gender) {
    genderValid = gender.isNotEmpty;
    validSink();
  }

  void nameValidate(String name) {
    nameValid = name.isNotEmpty;
    validSink();
  }

  void validSink() {
    widget.vaildStreamController.sink.add(isValid);
  }
}
