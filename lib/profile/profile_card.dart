// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:widget_test/profile/profile_data.dart';
import 'package:widget_test/profile/profile_image.dart';

class ProfileCard extends StatelessWidget {
  final VoidCallback? onTap;
  final ProfileData _profileData;

  const ProfileCard({
    super.key,
    this.onTap,
    required ProfileData profileData,
  }) : _profileData = profileData;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: ProfileImage(radius: 30, defaultImage: AssetImage("asset/images/default_profile_image.jpg")),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_profileData.job),
                          Text(_profileData.company),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                    child: Text(
                  _profileData.information,
                  textAlign: TextAlign.start,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
