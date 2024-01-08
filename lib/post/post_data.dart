class PostData {
  final int id;
  final String title;
  final String content;
  final int view;
  final int hit;
  final String createdAt;
  final String updatedAt;
  final PostUserData user;

  PostData({
    required this.id,
    required this.title,
    required this.content,
    required this.view,
    required this.hit,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        view: json['view'],
        hit: json['hit'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        user: PostUserData.fromJson(json['user']),
      );
}

class PostUserData {
  final String type;
  final int id;
  final String name;
  final String? image;

  PostUserData({
    required this.type,
    required this.id,
    required this.name,
    required this.image,
  });

  factory PostUserData.fromJson(Map<String, dynamic> json) => PostUserData(
        type: json['type'],
        id: json['id'],
        name: json['name'],
        image: json['image'],
      );
}
