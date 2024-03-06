import 'package:flutter/material.dart';
import 'package:widget_test/post/detail/comment/comment.dart';
import 'package:widget_test/post/detail/comment/comment_card.dart';

class CommentList extends StatelessWidget {
  final List<Comment> comments;
  final bool isReply;
  final Future<bool> Function(int commentId) onDelete;
  final Future<bool> Function(int commentId) onReport;
  final Future<bool> Function(int commentId) onReply;

  CommentList({
    super.key,
    required this.comments,
    required this.isReply,
    required this.onDelete,
    required this.onReport,
    required this.onReply,
  });

  final List<PopupMenuItem<String>> _menus = [
    const PopupMenuItem<String>(value: 'onReply', child: Text('대댓글 달기')),
    const PopupMenuItem<String>(value: 'onDelete', child: Text('삭제')),
    const PopupMenuItem<String>(value: 'onReport', child: Text('신고')),
  ];

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
              CommentCard(
                comment: comments[index],
                isReply: isReply,
                menus: PopupMenuButton(
                  onSelected: (name) async {
                    var response = false;
                    switch (name) {
                      case 'onReply':
                        response = await onReply(comments[index].id);
                        break;
                      case 'onDelete':
                        response = await onDelete(comments[index].id);
                        break;
                      case 'onReport':
                        response = await onReport(comments[index].id);
                        break;
                    }

                    if (response) {
                      // api 성공했을 때
                    } else {
                      // api 실패했을 때
                    }
                  },
                  itemBuilder: (context) {
                    var menus = <PopupMenuItem<String>>[];
                    if (comments[index].parentCommentId == null) menus.add(_menus[0]);
                    if (comments[index].isMine) {
                      menus.add(_menus[1]);
                    } else {
                      menus.add(_menus[2]);
                    }
                    return menus;
                  },
                ),
                onReply: onReply,
                onDelete: onDelete,
                onReport: onReport,
              ),
              Visibility(visible: !isReply, child: const Divider()),
            ],
          ),
        );
      },
    );
  }
}
