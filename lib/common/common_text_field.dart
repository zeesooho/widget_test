// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final EdgeInsets edgeInsets;

  const CommonTextField({
    Key? key,
    this.icon,
    this.labelText,
    this.hintText,
    this.helperText,
    this.helperStyle,
    this.isLast = false,
    this.edgeInsets = const EdgeInsets.all(8.0),
    required this.controller,
    this.onChange,
    required this.onClear,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.edgeInsets,
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
      child: Focus(
        descendantsAreFocusable: false,
        canRequestFocus: false,
        child: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              widget.controller.clear();
              widget.onClear();
            }),
      ),
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
