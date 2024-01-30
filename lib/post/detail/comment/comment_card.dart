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

  const CommentCard({
    super.key,
    required this.comment,
    required this.isReply,
    required this.menus,
  });

  @override
  Widget build(BuildContext context) {
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
                    const Row(
                      children: [
                        ProfileImage(
                          defaultImage: AssetImage("asset/images/default_profile_image.jpg"),
                          radius: 15,
                        ),
                        SizedBox(width: 4),
                        Text("이름 들어갈 자리", style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    Row(
                      children: [
                        menus,
                      ],
                    ),
                  ],
                ),
                Text(comment.content),
                Row(
                  children: [
                    Visibility(visible: comment.recommend != 0, child: const Icon(CupertinoIcons.heart)),
                    Visibility(visible: comment.recommend != 0, child: Text("${comment.recommend}  ")),
                    Text(comment.createdDate.toFormattedTime()),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: comment.children.isNotEmpty,
            child: CommentList(
              comments: comment.children,
              isReply: true,
              onEdit: () async {
                return true;
              },
              onDelete: () async {
                return true;
              },
              onReport: () async {
                return true;
              },
            ),
          ),
        ],
      ),
    );
  }
}
