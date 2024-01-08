import 'package:flutter/material.dart';
import 'package:widget_test/post/post_data.dart';
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
        title: const Text("게시판"),
      ),
      body: PostList(
        postDatas: [
          PostData(
            id: 1,
            title: '제목',
            content: '글내용',
            view: 1,
            hit: 1,
            createdAt: "2024-01-08",
            updatedAt: "2024-01-08",
            user: PostUserData(type: "icumbent", id: 1, name: "현직자1", image: "image"),
          ),
        ],
      ),
    );
  }
}
