abstract class PostData {
  final int id;
  final String title;
  final String content;
  final int view;
  final int recommend;
  final String createdDate;
  final String updatedDate;

  PostData({
    required this.id,
    required this.title,
    required this.content,
    required this.view,
    required this.recommend,
    required this.createdDate,
    required this.updatedDate,
  });
}

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

class PostUserData {
  final String type;
  final int id;
  final String name;
  final String? image;
  final String? additionalInfo;

  PostUserData({
    required this.type,
    required this.id,
    required this.name,
    this.image,
    this.additionalInfo,
  });

  factory PostUserData.fromJson(Map<String, dynamic> json) => PostUserData(
        type: json['type'],
        id: json['id'],
        name: json['name'],
        image: json['image'],
        additionalInfo: json['additionalInfo'],
      );
}
