class Group {
  final String id;
  final String name;

  const Group({required this.id, required this.name});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        id: json['id'],
        name: json['name'],
    );
  }
}