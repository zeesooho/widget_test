import 'dart:async';

import 'package:flutter/cupertino.dart';
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
              icon: const Icon(Icons.done, color: CupertinoColors.activeBlue),
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
  List<bool> isSelected2 = [false, false];

  int age = 0;
  bool gender = false;

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            const Text("계정 정보", style: TextStyle(fontSize: 16)),
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
            IdPwField(
              padding: const EdgeInsets.symmetric(vertical: 8),
              labelText: "비밀번호 확인",
              helperText: _pwCheckHelperText,
              helperStyle: _pwCheckHelperStyle,
              isPw: true,
              onChange: (pwCheck) => setState(() => pwCheckValidate(pwCheck)),
              onClear: () => setState(() => pwCheckValidate(_pwCheckController.text)),
              controller: _pwCheckController,
            ),
            const SizedBox(height: 45),
            const Text("기본 정보", style: TextStyle(fontSize: 16)),
            CommonTextField(
              labelText: "이름",
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              controller: _nameController,
              onChange: (name) => setState(() => nameValidate(name)),
              onClear: () => setState(() => nameValidate("")),
              isLast: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: CupertinoPicker.builder(
                      itemExtent: 48,
                      childCount: 54,
                      onSelectedItemChanged: (index) => setState(
                        () {
                          age = index + 17;
                          ageValidate(age);
                        },
                      ),
                      itemBuilder: (context, index) {
                        if (index == 0) return const Center(child: Text("나이 선택"));
                        return Center(child: Text("${index + 17}"));
                      },
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: LayoutBuilder(
                      builder: (context, constraint) => ToggleButtons(
                        constraints: BoxConstraints.expand(width: constraint.maxWidth / 2 - 4),
                        isSelected: isSelected2,
                        disabledColor: Colors.grey,
                        selectedColor: Colors.white,
                        fillColor: const Color.fromARGB(0xFF, 0x9E, 0x78, 0x56),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        onPressed: (index) {
                          setState(() {
                            isSelected2[index] = true;
                            isSelected2[1 - index] = false;
                            genderValid = true;
                            gender = (1 - index) == 0 ? true : false;
                            validSink();
                          });
                        },
                        children: const [
                          Text(
                            "남자",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "여자",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 회원가입 버튼 눌렀을 시
  void signUp() {
    // form 검증 로직
    widget.onSignUp("id: ${_idController.text}, pw: ${_pwController.text}, name: ${_nameController.text}, age: $age, gender: $gender");
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

  void ageValidate(int age) {
    ageValid = age > 17;
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
