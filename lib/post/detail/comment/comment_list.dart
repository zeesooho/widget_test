import 'package:flutter/material.dart';
import 'package:widget_test/post/detail/comment/comment.dart';
import 'package:widget_test/post/detail/comment/comment_card.dart';

class CommentList extends StatelessWidget {
  final List<Comment> comments;
  final bool isReply;
  final Future<bool> Function() onEdit;
  final Future<bool> Function() onDelete;
  final Future<bool> Function() onReport;

  CommentList({
    super.key,
    required this.comments,
    required this.isReply,
    required this.onEdit,
    required this.onDelete,
    required this.onReport,
  });

  final _menuMine = [
    const PopupMenuItem<String>(value: 'onEdit', child: Text('수정')),
    const PopupMenuItem<String>(value: 'onDelete', child: Text('삭제')),
  ];

  final _menuOthers = [const PopupMenuItem<String>(value: 'onReport', child: Text('신고'))];

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
                      case 'onEdit':
                        response = await onEdit();
                        break;
                      case 'onDelete':
                        response = await onDelete();
                        break;
                      case 'onReport':
                        response = await onReport();
                        break;
                    }

                    if (response) {
                      // api 성공했을 때
                    } else {
                      // api 실패했을 때
                    }
                  },
                  itemBuilder: (context) {
                    return comments[index].isMine ? _menuMine : _menuOthers;
                  },
                ),
              ),
              Visibility(visible: !isReply, child: const Divider()),
            ],
          ),
        );
      },
    );
  }
}
