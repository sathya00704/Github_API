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
    print(url);

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'token ${Api.token}'
      });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Successful response
        final responseData = json.decode(response.body) as Map<String, dynamic>;

        String? name = responseData['name'];
        print(name ?? 'Name not provided');

        user = User(
          username: responseData['login'] ?? '',
          imageUrl: responseData['avatar_url'] ?? '',
          followers: responseData['followers'] ?? 0,
          followings: responseData['followings'] ?? 0,
          public_repo: responseData['public_repos'] ?? 0,
          joined_data: responseData['created_at'] ?? '',
        );

        notifyListeners();
      } else {
        // If response status code is not in the success range
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Catching any exceptions
      print('Error: $e');
    }

  }
}
