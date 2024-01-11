import 'package:flutter/material.dart';

import 'create_post_widget.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var createPostWidget = CreatePostWidget(
      onCreatePost: (title, content) async {
        print(title);
        print(content);
        return true;
      },
    );
    var onCreatePost = createPostWidget.action;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("게시글 작성"),
        actions: [onCreatePost],
      ),
      body: createPostWidget,
    );
  }
}
