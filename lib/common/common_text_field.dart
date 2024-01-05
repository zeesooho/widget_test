import 'package:flutter/material.dart';

import 'helper_style.dart';

class CommonTextField extends StatefulWidget {
  final Icon? icon;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final HelperStyle? helperStyle;
  final bool isLast;
  final TextEditingController controller;
  final Function(String)? onChange;
  final Function() onClear;

  const CommonTextField({
    super.key,
    this.icon,
    this.labelText,
    this.hintText,
    this.helperText,
    this.helperStyle,
    this.onChange,
    this.isLast = false,
    required this.controller,
    required this.onClear,
  });

  @override
  State<StatefulWidget> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: commonDecoration(widget, CommonSuffixIcon(widget: widget)),
        controller: widget.controller,
        onChanged: widget.onChange,
        textInputAction: widget.isLast ? TextInputAction.done : TextInputAction.next,
        onSubmitted: widget.isLast ? (_) => FocusScope.of(context).unfocus() : (_) => FocusScope.of(context).nextFocus(),
      ),
    );
  }
}

class CommonSuffixIcon extends StatelessWidget {
  const CommonSuffixIcon({
    super.key,
    required this.widget,
  });

  final CommonTextField widget;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.controller.text.isNotEmpty,
      child: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            widget.controller.clear();
            widget.onClear();
          }),
    );
  }
}

InputDecoration commonDecoration(CommonTextField widget, Widget suffixIcon) {
  return InputDecoration(
    icon: widget.icon,
    hintText: widget.hintText,
    labelText: widget.labelText,
    helperText: widget.helperText,
    helperStyle: widget.helperStyle?.style,
    enabledBorder: getInputBorder(const Color.fromARGB(0xFF, 0x9E, 0x78, 0x56)),
    focusedBorder: getInputBorder(const Color.fromARGB(0xFF, 0x9E, 0x78, 0x56), bold: true),
    errorBorder: getInputBorder(Colors.red),
    fillColor: Colors.grey.shade300,
    suffixIcon: suffixIcon,
  );
}

OutlineInputBorder getInputBorder(Color color, {bool bold = false}) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: bold ? 2 : 1,
      ),
    );
