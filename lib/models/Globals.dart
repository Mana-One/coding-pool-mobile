library globals;

import 'CommentData.dart';
import 'Models.dart';

List<PostData> timelinePostsData = [];
List<PostData> myPostsData = [];
List<PostData> userPostsData = [];
UserStats connectedUserStats = UserStats(id: '', username: '', memberSince: '', followers: 0, following: 0, programs: 0, competitions_entered: 0, competitions_won: 0);
bool isUsernameUsed = true;
List<CommentData> comments = [];
String? token = '';
int myPostsNb = 0;
int userPostsNb = 0;

enum ImageSourceType { gallery, camera }