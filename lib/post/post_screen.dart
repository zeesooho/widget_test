import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_test/post/post_card.dart';
import 'package:widget_test/post/post_list.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("게시판"),
      ),
      body: PostList(),
    );
  }
}
