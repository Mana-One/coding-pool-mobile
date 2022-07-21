class PublicationCreation {
  final String content;

  const PublicationCreation({required this.content});

  factory PublicationCreation.fromJson(Map<String, dynamic> json) {
    return PublicationCreation(
      content: json['content'],
    );
  }
}