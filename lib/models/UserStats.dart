import 'dart:io';

class UserStats {
  final String id;
  final String username;
  final String picture;
  final String memberSince;
  final bool isFollowing;
  final int followers;
  final int following;
  final int programs;
  final int competitions_entered;
  final int competitions_won;

  const UserStats({required this.id, required this.username, required this.picture, required this.memberSince, required this.isFollowing, required this.followers, required this.following, required this.programs, required this.competitions_entered, required this.competitions_won});

  factory UserStats.fromJson(Map<String, dynamic> json) {
    if(json['picture'] == null )
      return UserStats(
          id: json['id'],
          username: json['username'],
          picture: 'https://i.pinimg.com/736x/59/0d/1e/590d1e8463e03b9b5f413000c807f41b.jpg',
          memberSince: json['memberSince'],
          isFollowing: json['isFollowing'],
          followers: json['followers'],
          following: json['following'],
          programs: json['programs'],
          competitions_entered: json['competitions_entered'],
          competitions_won: json['competitions_won']
      );
    return UserStats(
        id: json['id'],
        username: json['username'],
        picture: json['picture'],
        memberSince: json['memberSince'],
        isFollowing: json['isFollowing'],
        followers: json['followers'],
        following: json['following'],
        programs: json['programs'],
        competitions_entered: json['competitions_entered'],
        competitions_won: json['competitions_won']
    );
  }
}