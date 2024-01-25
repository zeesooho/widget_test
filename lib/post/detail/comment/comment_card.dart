import 'package:flutter/cupertino.dart';
import 'package:widget_test/post/detail/comment/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(comment.content),
        Text(comment.recommend.toString()),
        Text(comment.createdDate.toString()),
      ],
    );
  }
}
