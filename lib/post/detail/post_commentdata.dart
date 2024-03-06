class PostCommentdata {
  final int postId;
  final String content;
  final int? parentCommendId;

  PostCommentdata({
    required this.postId,
    required this.content,
    this.parentCommendId,
  });
}
