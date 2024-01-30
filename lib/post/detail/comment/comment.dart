import 'dart:collection';

class Comment {
  final int id;
  final int recommend;
  final int? parentCommentId;
  final int? incumbentId;
  final int? studentId;
  final bool isMine;
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
    required this.isMine,
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
        isMine: false,
        content: json['content'],
        createdDate: json['createdDate'],
        updatedDate: json['updatedDate'],
      );

  static List<Comment> listFromJson(List<dynamic> jsonArray) {
    Map<int, Comment> comments = {};
    Queue<Comment> children = Queue();

    for (var json in jsonArray) {
      var comment = Comment.fromJson(json);
      comment.parentCommentId != null ? children.add(comment) : comments[comment.id] = comment;
    }

    while (children.isNotEmpty) {
      var child = children.removeFirst();
      comments[child.parentCommentId]?.children.add(child);
    }
    return comments.values.map((comment) => comment).toList();
  }
}
