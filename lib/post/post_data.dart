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
