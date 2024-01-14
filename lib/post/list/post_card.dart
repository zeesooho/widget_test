import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:widget_test/post/detail/post_string_format.dart';
import 'package:widget_test/profile/profile_image.dart';

import './post_card_data.dart';
export 'post_card_data.dart';

class PostCard extends StatelessWidget {
  final PostCardData postCardData;
  final int maxLines;
  final TextOverflow contentOverflow;
  final Function(int id, String? category)? onTap;

  PostCard({
    super.key,
    required this.postCardData,
    this.maxLines = 1,
    this.contentOverflow = TextOverflow.ellipsis,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                if (onTap != null) onTap!(postCardData.id, postCardData.category);
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileImage(radius: 25, uri: postCardData.user.image),
                        nameWidget(),
                        dateWidget(),
                        viewWidget(filled: false),
                        recommendWidget(filled: false),
                      ],
                    ),
                    const SizedBox(height: 10),
                    contentWidget(),
                  ],
                ),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
        ],
      ),
    );
  }

  Widget recommendWidget({bool filled = false, Color? color}) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          filled ? Icon(CupertinoIcons.heart_fill, color: color) : Icon(CupertinoIcons.heart, color: color),
          Text(" ${postCardData.recommend}"),
        ],
      ),
    );
  }

  Widget viewWidget({bool filled = false, Color? color}) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          filled ? Icon(CupertinoIcons.eye_fill, color: color) : Icon(CupertinoIcons.eye, color: color),
          Text("  ${postCardData.view}"),
        ],
      ),
    );
  }

  Widget dateWidget() {
    return Expanded(
      flex: 2,
      child: Text(postCardData.createdDate.toSimpleTime()),
    );
  }

  Widget nameWidget() {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          postCardData.user.type == 'incumbent' ? _incumbentTag : _studentTag,
          Text(postCardData.user.name),
        ],
      ),
    );
  }

  Widget contentWidget() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postCardData.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            postCardData.content.toSimpleContent(maxLines),
            style: TextStyle(
              overflow: contentOverflow,
              fontSize: 14,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  final Widget _incumbentTag = Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.blue,
    ),
    child: const Padding(
      padding: EdgeInsets.all(4),
      child: Text('현직자'),
    ),
  );

  final Widget _studentTag = Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.amber,
    ),
    child: const Padding(
      padding: EdgeInsets.all(4),
      child: Text('학생'),
    ),
  );
}
