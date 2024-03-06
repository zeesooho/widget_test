import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_test/common/common_text_field.dart';
import 'package:widget_test/common/default_modal.dart';
import 'package:widget_test/post/detail/comment/comment_list.dart';
import 'package:widget_test/profile/profile_image.dart';

import 'post_commentdata.dart';
import 'post_detail_data.dart';
import 'post_string_format.dart';

export 'post_detail_data.dart';

class PostDetail extends StatefulWidget {
  final PostDetailData postDetailData;
  final Map<String, Future<bool> Function()> menuItems;
  final Future<bool> Function() onRecommend;
  final Future<PostDetailData> Function() onRefresh;
  final Future<bool> Function(PostCommentdata commentData) onPostComment;
  final Future<bool> Function(int commentId) onEditComment;
  final Future<bool> Function(int commentId) onDeleteComment;
  final Future<bool> Function(int commentId) onReportComment;

  const PostDetail({
    super.key,
    required this.postDetailData,
    required this.menuItems,
    required this.onRecommend,
    required this.onRefresh,
    required this.onPostComment,
    required this.onEditComment,
    required this.onDeleteComment,
    required this.onReportComment,
  });

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late PostDetailData _postDetailData;
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  bool isReply = false;
  int? parentCommentId;

  @override
  void initState() {
    super.initState();
    _postDetailData = widget.postDetailData;

    _textFieldFocus.addListener(() {
      if (!_textFieldFocus.hasFocus && _commentController.text.isEmpty) {
        isReply = false;
        parentCommentId = null;
      }
    });
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
                      profileWidget(_postDetailData.userData.image,
                          "${_postDetailData.userData.name ?? ''} ${_postDetailData.userData.type == 'incumbent' ? _postDetailData.userData.additionalInfo?.companyName : _postDetailData.userData.additionalInfo?.shcool}"),
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
                      CommentList(
                        comments: _postDetailData.comments,
                        isReply: false,
                        onReply: (commentId) async {
                          FocusScope.of(context).requestFocus(_textFieldFocus);
                          isReply = true;
                          parentCommentId = commentId;
                          return true;
                        },
                        onDelete: (commentId) async {
                          var response = await widget.onDeleteComment(commentId);
                          if (response) onRefresh();
                          return response;
                        },
                        onReport: (commentId) async {
                          var textController = TextEditingController();
                          showModal(
                            context,
                            title: '신고하기',
                            child: Column(
                              children: [
                                CommonTextField(
                                  color: CupertinoColors.activeBlue,
                                  controller: textController,
                                  hintText: '신고 사유',
                                  onClear: () => {},
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: CupertinoButton(
                                    color: CupertinoColors.activeBlue,
                                    child: const Text('신고하기'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                          return true;
                        },
                      ),
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
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          focusNode: _textFieldFocus,
                          decoration: InputDecoration(hintText: isReply ? '대댓글 작성' : '댓글 작성'),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () async {
                          var response = await widget.onPostComment(PostCommentdata(
                            postId: _postDetailData.id,
                            content: _commentController.text,
                            parentCommendId: parentCommentId,
                          ));
                          if (response) {
                            _commentController.clear();
                            isReply = false;
                            parentCommentId = null;
                            onRefresh();
                          }
                        },
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

  Widget profileWidget(String? image, String name) {
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
            Text(
              name,
              style: const TextStyle(fontSize: 16),
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
