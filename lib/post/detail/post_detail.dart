import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_test/post/detail/comment/comment_list.dart';

import 'post_detail_data.dart';
import 'post_string_format.dart';

export 'post_detail_data.dart';

class PostDetail extends StatefulWidget {
  final PostDetailData postDetailData;
  final Map<String, Future<bool> Function()> menuItems;
  final Future<bool> Function() onRecommend;
  final Future<PostDetailData> Function() onRefresh;

  const PostDetail({
    super.key,
    required this.postDetailData,
    required this.menuItems,
    required this.onRecommend,
    required this.onRefresh,
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
          onSelected: (name) async {
            var refresh = await widget.menuItems[name]!();
            if (refresh) onRefresh();
          },
          itemBuilder: (context) {
            return widget.menuItems.keys.map((e) => PopupMenuItem<String>(value: e, child: Text(e))).toList();
          },
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget(),
                      const SizedBox(height: 8),
                      contentWidget(),
                      Row(
                        children: [
                          viewArea(),
                          recommendArea(filled: _postDetailData.isRecommend, color: CupertinoColors.activeBlue),
                        ],
                      ),
                      const Divider(),
                      CommentList(comments: _postDetailData.comments, isReply: false),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
                width: double.infinity,
                child: Text('댓글 작성'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentWidget() {
    return SizedBox(
      width: double.infinity,
      child: Text(
        _postDetailData.content,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 16,
          height: 1.8,
        ),
      ),
    );
  }

  Widget titleWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _postDetailData.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Center(child: Text(_postDetailData.createdDate.toSimpleTime())),
      ],
    );
  }

  Widget recommendArea({bool filled = false, Color? color}) {
    var child = filled ? Icon(CupertinoIcons.heart_fill, color: color) : const Icon(CupertinoIcons.heart);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            var refresh = await widget.onRecommend();
            if (refresh) onRefresh();
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

  void onRefresh() {
    widget.onRefresh().then((newPostDetailData) => setState(() => _postDetailData = newPostDetailData));
  }
}
