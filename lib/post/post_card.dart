import 'package:flutter/material.dart';
import 'package:widget_test/post/post_data.dart';

class PostCard extends StatelessWidget {
  final PostData postData;

  const PostCard({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(postData.user.name),
            Text(postData.user.type),
          ],
        ),
        Column(
          children: [
            Text(postData.title),
            Text(postData.content),
          ],
        ),
        Visibility(
          visible: postData.createdAt != postData.updatedAt,
          child: const Text("(수정됨)"),
        ),
        Text("view: ${postData.view}"),
        Text("hit: ${postData.hit}"),
      ],
    );
  }
}
