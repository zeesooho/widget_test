import 'dart:math';

import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    var random = Random.secure();
    return Container(
      color: Color.fromARGB(
        0xFF,
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
      ),
      height: 60,
    );
  }
}
