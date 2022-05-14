import 'package:coding_pool_v0/views/MainScreens/Settings.dart';

class User {
  final String id;
  final String username;

  const User({
    required this.id,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], username: json['username'],);
  }
}

class UserSignIn {
  final String email;
  final String password;

  const UserSignIn({
    required this.email,
    required this.password,
  });

  factory UserSignIn.fromJson(Map<String, dynamic> json) {
    return UserSignIn(email: json['email'], password: json['password'],);
  }
}

class UserSignUp {
  final String email;
  final String username;
  final String password;

  const UserSignUp({
    required this.email,
    required this.username,
    required this.password,
  });

  factory UserSignUp.fromJson(Map<String, dynamic> json) {
    return UserSignUp(email: json['email'], username: json['username'], password: json['email']);
  }
}

class Author {
  final String id;
  final String username;

  const Author({required this.id, required this.username});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], username: json['username']);
  }

}

class PostData {
  final String id;
  final String content;
  final String createdAt;
  final Author author;
  final int likes;
  final int comments;
  final bool isLiked;

  const PostData({required this.id, required this.content, required this.createdAt, required this.author, required this.likes, required this.comments, required this.isLiked});

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
        id: json['id'],
        content: json['content'],
        createdAt: json['createdAt'],
        author: Author.fromJson(json['author']),
        likes: json['likes'],
        comments: json['comments'],
        isLiked: json['isLiked']
    );
  }
}

class Post {
  final String id;
  final int total;
  final Uri? previous;
  final Uri? next;
  final List<PostData> data;

  const Post(
      {required this.id, required this.total, required this.previous, this.next, required this.data});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        total: json['total'],
        previous: json['title'],
        next: json['next'],
        data: json['data']
    );
  }
}

class CommentsData {
  final String id;
  final String content;
  final String createdAt;
  final Author leftBy;

  const CommentsData({required this.id, required this.content, required this.createdAt, required this.leftBy});

  factory CommentsData.fromJson(Map<String, dynamic> json) {
    return CommentsData(
        id: json['id'],
        content: json['content'],
        createdAt: json['createdAt'],
        leftBy: Author.fromJson(json['leftBy']),
    );
  }
}

class Comment {
  final String id;
  final int total;
  final Uri? previous;
  final Uri? next;
  final List<CommentsData> data;

  const Comment(
      {required this.id, required this.total, required this.previous, this.next, required this.data});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        total: json['total'],
        previous: json['title'],
        next: json['next'],
        data: json['data']
    );
  }
}

class UserStats {
  final String id;
  final String username;
  final String memberSince;
  final int followers;
  final int following;
  final int programs;
  final int competitions_entered;
  final int competitions_won;

  const UserStats({required this.id, required this.username,required this.memberSince,required this.followers, required this.following, required this.programs, required this.competitions_entered, required this.competitions_won});

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
        id: json['id'],
        username: json['username'],
        memberSince: json['memberSince'],
        followers: json['followers'],
        following: json['following'],
        programs: json['programs'],
        competitions_entered: json['competitions_entered'],
        competitions_won: json['competitions_won']
    );
  }
}

class UserInfos {
  final String id;
  final String username;
  final String wallet;
  final String email;
  final String role;

  const UserInfos({required this.id, required this.username, required this.wallet, required this.email, required this.role});

  factory UserInfos.fromJson(Map<String, dynamic> json) {
    return UserInfos(
        id: json['id'],
        username: json['username'],
        wallet: json['wallet'],
        email: json['email'],
        role: json['role'],
    );
  }
}

class PublicationCreation {
  final String content;

  const PublicationCreation({required this.content});

  factory PublicationCreation.fromJson(Map<String, dynamic> json) {
    return PublicationCreation(
        content: json['content'],
    );
  }
}

class ChangePassword {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePassword({required this.oldPassword, required this.newPassword, required this.confirmPassword});

  factory ChangePassword.fromJson(Map<String, dynamic> json) {
    return ChangePassword(
        oldPassword: json['oldPassword'],
        newPassword: json['newPassword'],
        confirmPassword: json['confirmPassword'],
    );
  }
}

