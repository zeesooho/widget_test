import 'package:flutter/material.dart';

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
