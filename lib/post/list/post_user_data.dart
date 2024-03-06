class PostUserData {
  final String type;
  final int? id;
  final String? name;
  final String? image;
  final AdditionalInfo? additionalInfo;

  PostUserData({
    required this.type,
    this.id,
    this.name,
    this.image,
    this.additionalInfo,
  });

  factory PostUserData.fromJson(Map<String, dynamic> json) => PostUserData(
        type: json['type'],
        id: json['id'],
        name: json['username'] ?? json['name'],
        image: json['image'],
        additionalInfo: json['additionalInfo'] != null ? AdditionalInfo.fromJson(json['additionalInfo']) : null,
      );
}

class AdditionalInfo {
  final String? companyName;
  final String? jobDescription;
  final String? major;
  final String? shcool;

  AdditionalInfo({
    this.companyName,
    this.jobDescription,
    this.major,
    this.shcool,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
        companyName: json['companyName'],
        jobDescription: json['jobDescription'],
        major: json['major'],
        shcool: json['shcool'],
      );
}
