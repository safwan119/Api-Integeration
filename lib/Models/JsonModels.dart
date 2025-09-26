class JsonModels {
  final num userId;
  final num id;
  final String title;
  final String body;

  JsonModels({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory JsonModels.fromJson(Map<String, dynamic> json) {
    return JsonModels(
      userId: json['userId'] as num,
      id: json['id'] as num,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}