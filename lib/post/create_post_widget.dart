import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePostWidget extends StatefulWidget {
  final String? title;
  final String? content;

  final CreatePostWidgetState createPostWidgetState = CreatePostWidgetState();
  final StreamController<bool> vaildStreamController = StreamController();
  final Future<bool> Function(String title, String content) onCreatePost;
  late final Widget action;

  CreatePostWidget({
    super.key,
    required this.onCreatePost,
    this.title,
    this.content,
  }) {
    action = StreamBuilder<bool>(
        stream: vaildStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!) {
            return CupertinoButton(
                padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
                onPressed: () => createPostWidgetState.onCreatePost(),
                child: Text(
                  title == null ? "작성 완료" : "수정 완료",
                  style: const TextStyle(color: CupertinoColors.activeBlue),
                ));
          }
          return CupertinoButton(
              padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
              onPressed: null,
              child: Text(
                title == null ? "작성 완료" : "수정 완료",
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
    _titleController.text = widget.title ?? "";
    _contentController.text = widget.content ?? "";

    _titleController.addListener(() {
      widget.vaildStreamController.add((titleValidate && contentValidate));
    });
    _contentController.addListener(() {
      widget.vaildStreamController.add((titleValidate && contentValidate));
    });
  }

  bool get titleValidate => _titleController.text.length >= 2 && _titleController.text.length <= 50;
  bool get contentValidate => _contentController.text.length >= 3;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(border: InputBorder.none, hintText: "제목을 입력하세요"),
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 1, width: constraint.maxWidth, color: Colors.grey.shade400),
                  Flexible(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              controller: _contentController,
                              decoration: const InputDecoration(border: InputBorder.none, hintText: "내용을 입력하세요"),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              style: const TextStyle(height: 2, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void onCreatePost() async {
    widget.onCreatePost(_titleController.text, _contentController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.removeListener(() {});
    _contentController.removeListener(() {});
  }
}
