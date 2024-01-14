import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:widget_test/post/post_data.dart';

import 'post_string_format.dart';

class PostCard extends StatelessWidget {
  final PostCardData postCardData;
  final int maxLines;
  final TextOverflow contentOverflow;
  final Function(int id, String? category)? onTap;

  PostCard({
    super.key,
    required this.postCardData,
    this.maxLines = 1,
    this.contentOverflow = TextOverflow.ellipsis,
    this.onTap,
  });

  final Container _incumbentTag = Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.blue,
    ),
    child: const Padding(
      padding: EdgeInsets.all(4),
      child: Text('현직자'),
    ),
  );

  final Container _studentTag = Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.amber,
    ),
    child: const Padding(
      padding: EdgeInsets.all(4),
      child: Text('학생'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                if (onTap != null) onTap!(postCardData.id, postCardData.category);
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileImage(radius: 25, uri: postCardData.user.image),
                        nameArea(),
                        dateArea(),
                        viewArea(filled: false),
                        recommendArea(filled: false),
                      ],
                    ),
                    const SizedBox(height: 10),
                    contentArea(),
                  ],
                ),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
        ],
      ),
    );
  }

  Widget recommendArea({bool filled = false, Color? color}) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          filled ? Icon(CupertinoIcons.heart_fill, color: color) : Icon(CupertinoIcons.heart, color: color),
          Text(" ${postCardData.recommend}"),
        ],
      ),
    );
  }

  Widget viewArea({bool filled = false, Color? color}) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          filled ? Icon(CupertinoIcons.eye_fill, color: color) : Icon(CupertinoIcons.eye, color: color),
          Text("  ${postCardData.view}"),
        ],
      ),
    );
  }

  Widget dateArea() {
    return Expanded(
      flex: 2,
      child: Text(postCardData.createdDate.toSimpleTime()),
    );
  }

  Widget nameArea() {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          postCardData.user.type == 'incumbent' ? _incumbentTag : _studentTag,
          Text(postCardData.user.name),
        ],
      ),
    );
  }

  Widget contentArea() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postCardData.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            postCardData.content.toSimpleContent(maxLines),
            style: TextStyle(
              overflow: contentOverflow,
              fontSize: 14,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

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
