import 'package:widget_test/post/post_data.dart';
import 'post_user_data.dart';

export 'post_user_data.dart';

class PostCardData extends PostData {
  final String? category;
  final PostUserData user;

  PostCardData({
    required super.id,
    required super.title,
    required super.content,
    required super.view,
    required super.recommend,
    required super.createdDate,
    required super.updatedDate,
    required this.user,
    this.category,
  });

  factory PostCardData.fromJson(Map<String, dynamic> json) => PostCardData(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        view: json['view'],
        recommend: json['recommend'],
        createdDate: json['createdDate'],
        updatedDate: json['updatedDate'],
        category: json['category'],
        user: PostUserData.fromJson(json['user']),
      );
}
