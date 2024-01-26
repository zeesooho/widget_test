import 'package:flutter/material.dart';
import 'package:widget_test/post/detail/comment/comment.dart';
import 'package:widget_test/post/detail/comment/comment_card.dart';

class CommentList extends StatelessWidget {
  final List<Comment> comments;
  final bool isReply;

  const CommentList({
    super.key,
    required this.comments,
    required this.isReply,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: comments.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: isReply ? const EdgeInsets.only(left: 12) : EdgeInsets.zero,
          child: Column(
            children: [
              CommentCard(comment: comments[index]),
              isReply ? Container() : const Divider(),
            ],
          ),
        );
      },
    );
  }
}
