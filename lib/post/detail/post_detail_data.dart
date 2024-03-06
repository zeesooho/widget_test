import 'package:widget_test/post/post_data.dart';
import 'package:widget_test/widget_test.dart';

import 'comment/comment.dart';

class PostDetailData extends PostData {
  final PostUserData userData;
  final String? type;
  final bool isMine;
  final bool isRecommend;
  final List<Comment> comments;

  PostDetailData({
    required super.id,
    required super.title,
    required super.content,
    required super.view,
    required super.recommend,
    required super.createdDate,
    required super.updatedDate,
    required this.userData,
    required this.type,
    required this.isMine,
    required this.isRecommend,
    required this.comments,
  });

  factory PostDetailData.fromJson(Map<String, dynamic> json) => PostDetailData(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        view: json['view'],
        recommend: json['recommend'],
        createdDate: json['createdDate'],
        updatedDate: json['updatedDate'],
        userData: PostUserData.fromJson(json['user']),
        type: json['type'],
        isMine: json['isMine'],
        isRecommend: json['isRecommend'],
        comments: Comment.listFromJson(json['comments']),
      );
}
