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
        name: json['username'],
        image: json['image'],
        additionalInfo: json['additionalInfo'],
      );
}
