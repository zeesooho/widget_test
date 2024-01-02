// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final Function(String, String) onSubmit;

  const LoginWidget({super.key, required this.onSubmit});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          TextButton(
            onPressed: () => widget.onSubmit(idController.text, pwController.text),
            style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.only(left: 28, right: 28, top: 14, bottom: 14))),
            child: const Text("로그인"),
          ),
        ],
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
              widget.controller.text.isNotEmpty && widget.isPw
                  ? IconButton(
                      onPressed: () => setState(() => _isHide = !_isHide),
                      icon: const Icon(Icons.visibility),
                    )
                  : Container(),
              widget.controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => widget.controller.clear()),
                    )
                  : Container(),
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
