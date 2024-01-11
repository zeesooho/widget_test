import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePostWidget extends StatefulWidget {
  final CreatePostWidgetState createPostWidgetState = CreatePostWidgetState();
  final StreamController<bool> vaildStreamController = StreamController();
  final Future<bool> Function(String title, String content) onCreatePost;
  late final Widget action;

  CreatePostWidget({
    super.key,
    required this.onCreatePost,
  }) {
    action = StreamBuilder<bool>(
        stream: vaildStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!) {
            return CupertinoButton(
                onPressed: () => createPostWidgetState.onCreatePost(),
                child: const Text(
                  "작성 완료",
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ));
          }
          return const CupertinoButton(
              onPressed: null,
              child: Text(
                "작성 완료",
              ));
        });
  }

  @override
  State<CreatePostWidget> createState() {
    // ignore: no_logic_in_create_state
    return createPostWidgetState;
  }
}

class CreatePostWidgetState extends State<CreatePostWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _titleController.addListener(() {
      widget.vaildStreamController.add((titleValidate && contentValidate));
    });
    _contentController.addListener(() {
      widget.vaildStreamController.add((titleValidate && contentValidate));
    });
  }

  bool get titleValidate =>
      _titleController.text.length >= 2 && _titleController.text.length <= 50;
  bool get contentValidate => _contentController.text.length > 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: _titleController),
        TextField(
          controller: _contentController,
          maxLines: 10,
          style: const TextStyle(height: 2),
        ),
      ],
    );
  }

  void onCreatePost() async {
    var response = await widget.onCreatePost(
        _titleController.text, _contentController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.removeListener(() {});
    _contentController.removeListener(() {});
  }
}
