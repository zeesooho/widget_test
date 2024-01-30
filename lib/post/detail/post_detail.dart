import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_test/post/detail/comment/comment_list.dart';
import 'package:widget_test/profile/profile_image.dart';

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
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profileWidget(),
                      const SizedBox(height: 8),
                      Text(_postDetailData.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.grey.shade100,
                  elevation: 0,
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      const Expanded(child: TextField()),
                      CupertinoButton(
                        onPressed: () {},
                        child: const Text("작성"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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

  Widget profileWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ProfileImage(
          defaultImage: AssetImage("asset/images/default_profile_image.jpg"),
          radius: 20,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "이름 들어갈 자리",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 8),
            Text(_postDetailData.createdDate.toFormattedTime()),
          ],
        ),
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
