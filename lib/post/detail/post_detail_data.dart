import 'package:widget_test/post/post_data.dart';

class PostDetailData extends PostData {
  final int? incumbentId;
  final int? studentId;
  final int? categoryId;
  final int reported;
  final bool isMine;
  final bool isRecommend;

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
    this.categoryId,
    required this.reported,
    required this.isMine,
    required this.isRecommend,
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
        categoryId: json['categoryId'],
        reported: json['reported'],
        isMine: json['isMine'],
        isRecommend: json['isRecommend'],
      );
}
