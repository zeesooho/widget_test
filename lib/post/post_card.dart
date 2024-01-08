// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:widget_test/post/post_data.dart';

class PostCard extends StatelessWidget {
  final PostData postData;
  final int contentMaxLines;
  final TextOverflow contentOverflow;

  const PostCard({
    Key? key,
    required this.postData,
    this.contentMaxLines = 2,
    this.contentOverflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) => Column(
        children: [
          Container(
            color: Colors.white,
            // height: MediaQuery.of(context).size.height / 7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: postData.user.image != null
                            ? NetworkImage(postData.user.image!)
                            : const NetworkImage("https://robohash.org/hicveldicta.png?size=50x50&set=set1"),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(postData.user.name),
                          postData.user.type == 'incumbent' ? const Text('현직자') : const Text('학생'),
                        ],
                      ),
                      Visibility(
                        visible: postData.createdAt != postData.updatedAt,
                        child: const Text("수정됨", style: TextStyle(fontSize: 12)),
                      ),
                      Text("hit: ${postData.hit}"),
                      Text("view: ${postData.view}")
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(postData.title),
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
          Container(width: double.infinity, height: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
