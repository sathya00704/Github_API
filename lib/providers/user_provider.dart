import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_github_api/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_github_api/utils/api.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  User user = User(
    username: '',
    imageUrl: '',
    followers: 0,
    followings: 0,
    public_repo: 0,
    joined_data: '',
  );

  Future<void> getUserProfile(String username) async {
    final String url = '${Api.api}users/${username}';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'token ${Api.token}'
      });
      final responseData = json.decode(response.body) as Map<String, dynamic>;

      print(responseData['name']);

      user = User(
        username: responseData['login'] ?? '',
        imageUrl: responseData['avatar_url'] ?? '',
        followers: responseData['followers'] ?? 0,
        followings: responseData['followings'] ?? 0,
        public_repo: responseData['public_repos'] ?? 0,
        joined_data: responseData['created_at'] ?? '',
      );

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
