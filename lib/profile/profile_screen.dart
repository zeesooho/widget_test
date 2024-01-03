import 'package:flutter/material.dart';
import 'package:widget_test/profile/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (int i = 0; i < 5; i++) {
      children.add(const ProfileCard());
    }
    return Column(
      children: children,
    );
  }
}
