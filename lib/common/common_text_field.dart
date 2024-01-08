import 'package:flutter/cupertino.dart';
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
  final EdgeInsets? padding;

  const CommonTextField({
    super.key,
    this.icon,
    this.labelText,
    this.hintText,
    this.helperText,
    this.helperStyle,
    this.isLast = false,
    this.onChange,
    this.padding,
    required this.controller,
    required this.onClear,
  });

  @override
  State<StatefulWidget> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() => _visible = _focusNode.hasFocus && widget.controller.text.isNotEmpty));
    widget.controller.addListener(() => setState(() => _visible = _focusNode.hasFocus && widget.controller.text.isNotEmpty));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: TextField(
        decoration: commonDecoration(widget, CommonSuffixIcon(widget: widget, visible: _visible)),
        controller: widget.controller,
        onChanged: widget.onChange,
        focusNode: _focusNode,
        textInputAction: widget.isLast ? TextInputAction.done : TextInputAction.next,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(() {});
    widget.controller.removeListener(() {});
  }
}

class CommonSuffixIcon extends StatelessWidget {
  final bool visible;
  final CommonTextField widget;

  const CommonSuffixIcon({
    super.key,
    required this.visible,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
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
    // enabledBorder: getInputBorder(CupertinoColors.activeBlue),
    // focusedBorder: getInputBorder(CupertinoColors.activeBlue, bold: true),
    enabledBorder: getInputBorder(const Color.fromARGB(0xFF, 0x9E, 0x78, 0x56)),
    focusedBorder: getInputBorder(const Color.fromARGB(0xFF, 0x9E, 0x78, 0x56), bold: true),
    errorBorder: getInputBorder(CupertinoColors.systemRed),
    fillColor: CupertinoColors.white,
    filled: true,
    suffixIcon: suffixIcon,
  );
}

OutlineInputBorder getInputBorder(Color color, {bool bold = false}) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: bold ? 2 : 1,
      ),
    );
