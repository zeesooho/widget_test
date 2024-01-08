import 'package:flutter/material.dart';
import 'package:widget_test/post/post_card.dart';
import 'package:widget_test/post/post_data.dart';

class PostList extends StatefulWidget {
  final List<PostData> postDatas;

  const PostList({super.key, required this.postDatas});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.postDatas.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: PostCard(
            postData: widget.postDatas[index],
          ),
        );
      },
    );
  }
}
