library globals;

import 'Models.dart';

List<PostData> timelinePostsData = [];
List<PostData> myPostsData = [];
List<PostData> userPostsData = [];
UserStats connectedUserStats = UserStats(id: '', username: '', memberSince: '', followers: 0, following: 0, programs: 0, competitions_entered: 0, competitions_won: 0);
bool isUsernameUsed = true;