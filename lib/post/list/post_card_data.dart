import 'package:widget_test/post/post_data.dart';
import 'post_user_data.dart';

export 'post_user_data.dart';

class PostCardData extends PostData {
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
  });

  factory PostCardData.fromJson(Map<String, dynamic> json) => PostCardData(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        view: json['view'],
        recommend: json['recommend'],
        createdDate: json['createdDate'],
        updatedDate: json['updatedDate'],
        user: PostUserData.fromJson(json['user']),
      );
}
