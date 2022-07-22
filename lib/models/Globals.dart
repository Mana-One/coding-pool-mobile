library globals;

import 'package:coding_pool_v0/models/UserStats.dart';

import 'CommentData.dart';

UserStats connectedUserStats = UserStats(id: '', username: '', memberSince: '', followers: 0, following: 0, programs: 0, competitions_entered: 0, competitions_won: 0, isFollowing: true, picture: '');
bool isUsernameUsed = true;
List<CommentData> comments = [];
String? token = '';
int myPostsNb = 0;
int userPostsNb = 0;

enum ImageSourceType { gallery, camera }