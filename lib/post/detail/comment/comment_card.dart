import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_test/post/detail/comment/comment.dart';
import 'package:widget_test/post/detail/comment/comment_list.dart';
import 'package:widget_test/post/detail/post_string_format.dart';
import 'package:widget_test/profile/profile_image.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final PopupMenuButton menus;
  final bool isReply;
  final Future<bool> Function(int commentId) onReply;
  final Future<bool> Function(int commentId) onDelete;
  final Future<bool> Function(int commentId) onReport;

  const CommentCard({
    super.key,
    required this.comment,
    required this.isReply,
    required this.menus,
    required this.onReply,
    required this.onDelete,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    if (comment.userData == null) {
      return Card(
        shape: isReply ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)) : const BeveledRectangleBorder(),
        color: isReply ? Colors.grey.shade100 : null,
        elevation: 0,
        child: Column(
          children: [
            Padding(
              padding: isReply ? const EdgeInsets.only(left: 12, top: 12, bottom: 12) : const EdgeInsets.only(right: 4),
              child: const Center(child: Text('삭제된 댓글입니다.')),
            ),
            replyWidget(),
          ],
        ),
      );
    }
    return Card(
      shape: isReply ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)) : const BeveledRectangleBorder(),
      color: isReply ? Colors.grey.shade100 : null,
      elevation: 0,
      child: Column(
        children: [
          Padding(
            padding: isReply ? const EdgeInsets.only(left: 12, top: 12, bottom: 12) : const EdgeInsets.only(right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    profileWidget(comment.userData!.image, comment.userData!.name ?? ''),
                    menuWIdget(),
                  ],
                ),
                contentWidget(),
                infoWidget(),
              ],
            ),
          ),
          replyWidget(),
        ],
      ),
    );
  }

  Visibility replyWidget() {
    return Visibility(
      visible: comment.children.isNotEmpty,
      child: CommentList(
        comments: comment.children,
        isReply: true,
        onReply: onReply,
        onDelete: onDelete,
        onReport: onReport,
      ),
    );
  }

  Widget menuWIdget() {
    return Row(
      children: [
        menus,
      ],
    );
  }

  Widget profileWidget(String? image, String name) {
    return Row(
      children: [
        ProfileImage(
          uri: image,
          defaultImage: const AssetImage("asset/images/default_profile_image.jpg"),
          radius: 15,
        ),
        const SizedBox(width: 4),
        Text(name, style: const TextStyle(fontSize: 15)),
      ],
    );
  }

  Widget contentWidget() => Text(comment.content, style: const TextStyle(height: 1.5));

  Widget infoWidget() {
    return Row(
      children: [
        Visibility(visible: comment.recommend != 0, child: const Icon(CupertinoIcons.heart)),
        Visibility(visible: comment.recommend != 0, child: Text("${comment.recommend}  ")),
        Text(comment.createdDate.toFormattedTime()),
      ],
    );
  }
}
