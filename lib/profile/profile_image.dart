import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String? uri;
  final double radius;

  const ProfileImage({
    super.key,
    this.uri,
    this.radius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: uri != null
          ? CircleAvatar(
              radius: radius,
              backgroundImage: NetworkImage(uri!),
            )
          : CircleAvatar(
              radius: radius,
              backgroundImage: const AssetImage("asset/images/default_profile_image.jpg"),
            ),
    );
  }
}
