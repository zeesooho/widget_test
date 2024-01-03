import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final bool Function(String, String) signIn;
  final Function() signUp;

  const LoginWidget({
    super.key,
    required this.signIn,
    required this.signUp,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  bool tried = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextField(
            hintText: "dongajul@dongajul.com",
            labelText: "아이디",
            helperText: "이메일 형식으로 해주세요",
            controller: idController,
          ),
          CommonTextField(
            labelText: "비밀번호",
            helperText: "숫자, 문자를 포함하여 8자 이상 입력해주세요.",
            isPw: true,
            controller: pwController,
          ),
          ForgotPassword(visibility: tried),
          SignInButton(onPressed: signIn),
          SignUpButton(onPressed: widget.signUp),
        ],
      ),
    );
  }

  void signIn() => setState(() => tried = widget.signIn(idController.text, pwController.text));
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
    required this.visibility,
  });

  final bool visibility;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextButton(
          onPressed: () => {},
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

  final VoidCallback onPressed;

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

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(18),
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

class CommonTextField extends StatefulWidget {
  final Icon? icon;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final bool isPw;
  final TextEditingController controller;

  const CommonTextField({
    Key? key,
    this.icon,
    this.labelText,
    this.hintText,
    this.helperText,
    this.isPw = false,
    required this.controller,
  }) : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _isHide = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          icon: widget.icon,
          hintText: widget.hintText,
          labelText: widget.labelText,
          helperText: widget.helperText,
          enabledBorder: getInputBorder(const Color.fromARGB(0xFF, 0x9E, 0x78, 0x56)),
          focusedBorder: getInputBorder(const Color.fromARGB(0xFF, 0x9E, 0x78, 0x56), bold: true),
          errorBorder: getInputBorder(Colors.red),
          fillColor: Colors.grey.shade300,
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: widget.controller.text.isNotEmpty && widget.isPw,
                child: IconButton(
                  onPressed: () => setState(() => _isHide = !_isHide),
                  icon: const Icon(Icons.visibility),
                ),
              ),
              Visibility(
                visible: widget.controller.text.isNotEmpty,
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() => widget.controller.clear()),
                ),
              ),
            ],
          ),
        ),
        controller: widget.controller,
        onChanged: (_) => setState(() => {}),
        obscureText: widget.isPw && _isHide,
        obscuringCharacter: "*",
        textInputAction: widget.isPw ? TextInputAction.done : TextInputAction.next,
        onSubmitted: widget.isPw ? (_) => FocusScope.of(context).unfocus() : (_) => FocusScope.of(context).nextFocus(),
        keyboardType: widget.isPw ? TextInputType.text : TextInputType.emailAddress,
      ),
    );
  }

  OutlineInputBorder getInputBorder(Color color, {bool bold = false}) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: bold ? 2 : 1,
        ),
      );
}
