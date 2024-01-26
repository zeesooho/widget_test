import 'package:flutter/cupertino.dart';
import 'package:widget_test/post/detail/comment/comment.dart';
import 'package:widget_test/post/detail/comment/comment_list.dart';
import 'package:widget_test/post/detail/post_string_format.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(comment.content),
            Text(comment.recommend.toString()),
            Text(comment.createdDate.toSimpleTime()),
          ],
        ),
        comment.children.isNotEmpty ? CommentList(comments: comment.children, isReply: true) : Container(),
      ],
    );
  }
}
