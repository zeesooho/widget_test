import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:widget_test/post/post_data.dart';
import 'package:widget_test/post/post_string_format.dart';

class PostDetail extends StatefulWidget {
  final PostDetailData postDetailData;
  final Map<String, Function> actions;
  final Future<PostDetailData> Function() onRecommend;

  const PostDetail({
    super.key,
    required this.postDetailData,
    required this.actions,
    required this.onRecommend,
  });

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late PostDetailData _postDetailData;

  @override
  void initState() {
    super.initState();
    _postDetailData = widget.postDetailData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("게시글 상세보기"), centerTitle: true, actions: [
        PopupMenuButton(
          onSelected: (name) {
            widget.actions[name]!();
          },
          itemBuilder: (context) {
            return widget.actions.keys.map((e) => PopupMenuItem<String>(value: e, child: Text(e))).toList();
          },
        ),
      ]),
      body: Center(
        child: Column(
          children: [
            Text('id: ${_postDetailData.id}'),
            Text('studentId: ${_postDetailData.studentId}'),
            Text('incumbentId ${_postDetailData.incumbentId}'),
            Text('categoryId ${_postDetailData.categoryId}'),
            Text('reported ${_postDetailData.reported}'),
            Text("title ${_postDetailData.title}"),
            Text("content ${_postDetailData.content}"),
            Text(_postDetailData.isMine ? "내꺼" : "남꺼"),
            viewArea(),
            recommendArea(filled: _postDetailData.isRecommend, color: CupertinoColors.activeBlue),
            Text('create ${_postDetailData.createdDate.toSimpleTime()}'),
          ],
        ),
      ),
    );
  }

  Widget recommendArea({bool filled = false, Color? color}) {
    var child = filled ? Icon(CupertinoIcons.heart_fill, color: color) : const Icon(CupertinoIcons.heart);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            widget.onRecommend().then((newPostDetailData) => setState(() => _postDetailData = newPostDetailData));
          },
          icon: child,
        ),
        Text("  ${_postDetailData.recommend}"),
      ],
    );
  }

  Widget viewArea({bool filled = false, Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        filled ? Icon(CupertinoIcons.eye_fill, color: color) : const Icon(CupertinoIcons.eye),
        Text("  ${_postDetailData.view}"),
      ],
    );
  }
}
