import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatefulWidget {
  final Icon? icon;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final HelperStyle? helperStyle;
  final bool isPw;
  final bool isLast;
  final TextEditingController controller;
  final Function(String)? onChange;
  final Function() onClear;

  const CommonTextField({
    Key? key,
    this.icon,
    this.labelText,
    this.hintText,
    this.helperText,
    this.helperStyle,
    this.onChange,
    this.isPw = false,
    this.isLast = false,
    required this.controller,
    required this.onClear,
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
          helperStyle: widget.helperStyle?.style,
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
                    onPressed: () {
                      widget.controller.clear();
                      widget.onClear();
                    }),
              ),
            ],
          ),
        ),
        controller: widget.controller,
        onChanged: widget.onChange,
        obscureText: widget.isPw && _isHide,
        obscuringCharacter: "●",
        textInputAction: widget.isLast ? TextInputAction.done : TextInputAction.next,
        onSubmitted: widget.isLast ? (_) => FocusScope.of(context).unfocus() : (_) => FocusScope.of(context).nextFocus(),
        keyboardType: widget.isPw ? TextInputType.text : TextInputType.emailAddress,
        inputFormatters: widget.isPw ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9~!@#\$%^&*]'))] : null,
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

class HelperStyle {
  final List<TextStyle> _styles = [
    const TextStyle(color: Colors.black),
    const TextStyle(color: Colors.blue),
    const TextStyle(color: Colors.red),
  ];

  final HelperState state;
  late final TextStyle style;

  HelperStyle({required this.state}) {
    style = _styles[state.index];
  }
}

enum HelperState {
  normal,
  correct,
  error,
}
