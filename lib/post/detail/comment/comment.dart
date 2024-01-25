class Comment {
  final int id;
  final int recommend;
  final int? parentCommentId;
  final int? incumbentId;
  final int? studentId;
  final String content;
  final String createdDate;
  final String updatedDate;
  final List<Comment> children = [];

  Comment({
    required this.id,
    required this.recommend,
    this.parentCommentId,
    this.incumbentId,
    this.studentId,
    required this.content,
    required this.createdDate,
    required this.updatedDate,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        recommend: json['recommend'],
        parentCommentId: json['parentCommentId'],
        incumbentId: json['incumbentId'],
        studentId: json['studentId'],
        content: json['content'],
        createdDate: json['createdDate'],
        updatedDate: json['updatedDate'],
      );

  static List<Comment> listFromJson(List<dynamic> json) {
    List<Comment> comments = json.map((comment) => Comment.fromJson(comment)).toList();
    List<Comment> children = comments.where((comment) => comment.parentCommentId != null).toList();

    for (var child in children) {
      comments.firstWhere((Comment comment) => comment.id == child.id).children.add(child);
    }

    return comments;
  }
}
