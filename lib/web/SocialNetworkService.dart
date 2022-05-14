import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


//OK

Future<void> likePublication(String publicationId) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.post(
    Uri.parse("https://coding-pool-api.herokuapp.com/likes/" + publicationId),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Success');
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to like post');
  }
}

// OK

Future<void> unlikePublication(String publicationId) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.delete(
    Uri.parse("https://coding-pool-api.herokuapp.com/likes/" + publicationId),
    body: { 'publicationId': publicationId},
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeesssssssssss');
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to unlike post');
  }
}


// OK
Future<void> commentPublication(String publicationId, String content) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.post(
    Uri.parse("https://coding-pool-api.herokuapp.com/comments"),
    body: {'content': content, 'publicationId': publicationId},
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeesssssssssss');
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to comment post');
  }
}

// OK

/*Future<void> deletePostComment(String publicationId) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.delete(
    Uri.parse("https://coding-pool-api.herokuapp.com/comments" + publicationId),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeesssssssssss');
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to delete post comment ');
  }
}
 */

// OK

Future<void> followUser(String userId) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.post(
    Uri.parse("https://coding-pool-api.herokuapp.com/users/follow/" + userId),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeesssssssssss');
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to follow user');
  }
}

//OK

Future<void> unfollowUser(String publicationId) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.delete(
    Uri.parse("https://coding-pool-api.herokuapp.com/users/unfollow/" + publicationId),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeesssssssssss unfollow user');
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to unfollow user');
  }
}

// OK dans Account

Future<Post> getConnectedUserPublications(List<PostData> posts) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.get(
    Uri.parse("https://coding-pool-api.herokuapp.com/publications/timeline/me?limit=20&offset=0"),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  Map<String, dynamic> map = jsonDecode(response.body);

  List<dynamic> listResponse = map['data'] ;

  for(int i=0; i<listResponse.length; i++) {
    Map<String, dynamic> mapPost = listResponse[i];
    PostData postData = PostData.fromJson(mapPost);
    print(postData.content);
    posts.add(postData);
  }

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeess');
    return jsonDecode(response.body) ;

  } else {
    throw Exception('Failed to fetch own timeline');
  }
}


// ok dans UserAccount.dart
Future<PostData> getUserPublications(List<PostData> posts, String userId) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.get(
    Uri.parse("https://coding-pool-api.herokuapp.com/publications/timeline/userId=$userId&limit=20&offset=0"),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  Map<String, dynamic> map = jsonDecode(response.body);

  List<dynamic> listResponse = map['data'] ;

  for(int i=0; i<listResponse.length; i++) {
    Map<String, dynamic> mapPost = listResponse[i];
    PostData postData = PostData.fromJson(mapPost);
    print(postData.content);
    posts.add(postData);
  }

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeess user account');
    return jsonDecode(response.body);

  } else {
    throw Exception('Failed to fetch user timeline');
  }
}

// OK

Future<void> createPublication(String content) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.post(
    Uri.parse("https://coding-pool-api.herokuapp.com/publications"),
    body: {'content': content},
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );


  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeess user account');
    return jsonDecode(response.body) ;

  } else {
    throw Exception('Failed to create publication');
  }
}

