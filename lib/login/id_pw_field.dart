import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_test/common/common_text_field.dart';

class IdPwField extends CommonTextField {
  final bool isPw;

  const IdPwField({
    super.key,
    this.isPw = false,
    super.icon,
    super.labelText,
    super.hintText,
    super.helperText,
    super.helperStyle,
    super.onChange,
    super.isLast,
    super.padding,
    required super.controller,
    required super.onClear,
  });

  @override
  State<IdPwField> createState() => _IdPwFieldState();
}

class _IdPwFieldState extends State<IdPwField> {
  final FocusNode _focusNode = FocusNode();
  bool _isHide = true;
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
        decoration: commonDecoration(
          widget,
          PwSuffixIcon(
            widget: widget,
            visible: _visible,
            toggleHide: toggleHide,
          ),
        ),
        focusNode: _focusNode,
        controller: widget.controller,
        onChanged: widget.onChange,
        obscureText: widget.isPw && _isHide,
        obscuringCharacter: "●",
        textInputAction: widget.isLast ? TextInputAction.done : TextInputAction.next,
        keyboardType: widget.isPw ? TextInputType.text : TextInputType.emailAddress,
        inputFormatters: widget.isPw ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9~!@#\$%^&*]'))] : null,
      ),
    );
  }

  void toggleHide() => setState(() => _isHide = !_isHide);

  OutlineInputBorder getInputBorder(Color color, {bool bold = false}) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: bold ? 2 : 1,
        ),
      );
}

class PwSuffixIcon extends StatelessWidget {
  final bool visible;

  const PwSuffixIcon({
    super.key,
    required this.widget,
    required this.toggleHide,
    required this.visible,
  });

  final IdPwField widget;
  final VoidCallback toggleHide;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: widget.isPw && visible,
          child: Focus(
            descendantsAreFocusable: false,
            canRequestFocus: false,
            child: IconButton(
              onPressed: toggleHide,
              icon: const Icon(Icons.visibility),
            ),
          ),
        ),
        Visibility(
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
        ),
      ],
    );
  }
}
