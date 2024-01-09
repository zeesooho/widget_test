import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:widget_test/post/post_data.dart';

class PostCard extends StatelessWidget {
  final PostData postData;
  final int contentMaxLines;
  final TextOverflow contentOverflow;

  PostCard({
    Key? key,
    required this.postData,
    this.contentMaxLines = 1,
    this.contentOverflow = TextOverflow.ellipsis,
  }) : super(key: key);

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
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileImage(radius: 25, uri: postData.user.image),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            postData.user.type == 'incumbent'
                                ? _incumbentTag
                                : _studentTag,
                            Text(postData.user.name),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(postData.createdAt.toSimpleTime()),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(CupertinoIcons.eye),
                            Text("  ${postData.hit}"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(CupertinoIcons.heart),
                            Text(" ${postData.hit}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postData.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          postData.content.toSimpleContent(contentMaxLines),
                          style: TextStyle(
                            overflow: contentOverflow,
                            fontSize: 14,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
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
              backgroundImage:
                  const AssetImage("asset/images/default_profile_image.jpg"),
            ),
    );
  }
}

extension PostCardFormat on String {
  //이메일 포맷 검증
  String toSimpleTime() {
    DateTime now = DateTime.now().toLocal();
    DateTime beforeHour =
        DateTime.now().toLocal().subtract(const Duration(hours: 1));
    DateTime todayStart = DateTime(now.year, now.month, now.day);

    DateTime dateTime = DateTime.parse(this).toLocal();

    if (dateTime.isAfter(beforeHour)) {
      // 1시간 이내
      var gapMinute =
          (now.millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch) /
              60000;
      if (gapMinute < 2) return "방금전";
      return "${gapMinute.toInt()}분 전";
    } else if (dateTime.isAfter(todayStart)) {
      // 오늘
      return DateFormat.Hm().format(dateTime);
    } else {
      // 그 이전
      return DateFormat.Md().format(dateTime);
    }
  }

  String toSimpleContent(int maxLines) {
    if (split('\n').length > maxLines) {
      var newContent = split('\n').sublist(0, maxLines).join('\n');
      return "$newContent\n⋯";
    } else {
      return this;
    }
  }
}
