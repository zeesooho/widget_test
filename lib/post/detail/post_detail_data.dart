import 'package:widget_test/post/post_data.dart';

import 'comment/comment.dart';

class PostDetailData extends PostData {
  final int? incumbentId;
  final int? studentId;
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
    this.incumbentId,
    this.studentId,
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
        incumbentId: json['incumbentId'],
        studentId: json['studentId'],
        isMine: json['isMine'],
        isRecommend: json['isRecommend'],
        comments: Comment.listFromJson(json['comments']),
      );
}
