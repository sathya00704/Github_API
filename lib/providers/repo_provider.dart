import 'dart:convert'; // Import dart:convert for json.decode
import 'package:flutter/material.dart';
import 'package:flutter_github_api/models/repo.dart';
import 'package:flutter_github_api/utils/api.dart';
import 'package:http/http.dart' as http;

class RepoProvider extends ChangeNotifier {
  List<Repo> _repoList = []; // Define _repoList as a private field

  List<Repo> get repoList {
    return [..._repoList];
  }

  Future<void> getRepoList(String username) async {
    if (username == null) {
      print('Username is null $username');
      return;
    }

    final link = Uri.parse('${Api.api}users/$username/repos'); // Convert link to Uri
    print('Requesting repositories for user: $username');
    print('API URL: $link');

    try {
      final response = await http.get(link, headers: {
        'Authorization': 'token ${Api.token}'
      });

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 404) {
        print('User not found on GitHub');
        return; // Exit early if user not found
      }

      // Proceed with processing the response if status code is not 404
      final responseData = json.decode(response.body);

      // Ensure responseData is a List
      if (responseData is List) {
        List<Repo> newList = [];

        // Process each repository in the response
        responseData.forEach((repoData) {
          Repo rep = Repo(
            repo_name: repoData['name'],
            created_date: repoData['created_at'],
            branch: repoData['default_branch'],
            language: repoData['language'],
            last_pushed: repoData['pushed_at'],
            url: repoData['html_url'],
            stars: repoData['stargazers_count'],
            description: repoData['description'],
          );

          newList.add(rep);
          printRepositoryDetails(rep);
        });

        _repoList = newList;
        _repoList.sort((a,b)=>b.created_date.compareTo(a.created_date));
        print('Repositories loaded successfully');
        notifyListeners();

      } else {
        print('Unexpected response format');
      }
    } catch (e) {
      print('Error fetching repositories: $e');
    }
  }

  void printRepositoryDetails(Repo repo) {
    print('Added Repo: ${repo.repo_name}');
    print('Created Date: ${repo.created_date}');
    print('Branch: ${repo.branch}');
    print('Language: ${repo.language}');
    print('Last Pushed: ${repo.last_pushed}');
    print('URL: ${repo.url}');
    print('Stars: ${repo.stars}');
    print('Description: ${repo.description}');
    print('------------------------');
  }
}
