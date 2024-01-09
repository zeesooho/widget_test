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
    this.contentMaxLines = 3,
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
                      ProfileImage(uri: postData.user.image),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(postData.user.name),
                            postData.user.type == 'incumbent' ? _incumbentTag : _studentTag,
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(postData.createdAt.toSimpleTime()),
                            Visibility(
                              visible: postData.createdAt != postData.updatedAt,
                              child: const Text("수정됨", style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.eye),
                            Text("  ${postData.hit}"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.hand_thumbsup),
                            Text(" ${postData.hit}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(postData.title),
                        const Divider(),
                        Text(
                          postData.content,
                          maxLines: contentMaxLines,
                          style: TextStyle(overflow: contentOverflow),
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

  const ProfileImage({
    super.key,
    this.uri,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: uri != null
          ? CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(uri!),
            )
          : const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("asset/images/default_profile_image.jpg"),
            ),
    );
  }
}

extension TimeFormat on String {
  //이메일 포맷 검증
  String toSimpleTime() {
    DateTime dateTime = DateTime.parse(this);
    return "${dateTime.hour} : ${dateTime.minute}";
  }
}
