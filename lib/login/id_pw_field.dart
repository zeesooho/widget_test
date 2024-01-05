import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_test/common/common_text_field.dart';

class IdPwField extends CommonTextField {
  final bool isPw;

  const IdPwField({
    Key? key,
    this.isPw = false,
    super.icon,
    super.labelText,
    super.hintText,
    super.helperText,
    super.helperStyle,
    super.onChange,
    super.isLast,
    required super.controller,
    required super.onClear,
  }) : super(key: key);

  @override
  State<IdPwField> createState() => _IdPwFieldState();
}

class _IdPwFieldState extends State<IdPwField> {
  bool _isHide = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: commonDecoration(
          widget,
          PwSuffixIcon(
            widget: widget,
            toggleHide: toggleHide,
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

  void toggleHide() => setState(() => _isHide = !_isHide);

  OutlineInputBorder getInputBorder(Color color, {bool bold = false}) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: bold ? 2 : 1,
        ),
      );
}

class PwSuffixIcon extends StatelessWidget {
  const PwSuffixIcon({
    super.key,
    required this.widget,
    required this.toggleHide,
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
          visible: widget.controller.text.isNotEmpty && widget.isPw,
          child: IconButton(
            onPressed: toggleHide,
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
    );
  }
}
