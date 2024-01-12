// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:widget_test/post/post_card.dart';
import 'package:widget_test/post/post_data.dart';

class PostList extends StatefulWidget {
  final List<PostData> postDatas;
  final ScrollController scrollController;
  final Function(int id, String? category)? onTap;

  const PostList({
    super.key,
    required this.postDatas,
    required this.scrollController,
    this.onTap,
  });

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      controller: widget.scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.postDatas.length,
      itemBuilder: (context, index) {
        return PostCard(
          postData: widget.postDatas[index],
          onTap: (id, category) {
            if (widget.onTap != null) widget.onTap!(id, category);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.scrollController.removeListener(() {});
  }
}
