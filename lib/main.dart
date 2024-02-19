import 'package:flutter/material.dart';
import 'package:flutter_github_api/providers/repo_provider.dart';
import 'package:flutter_github_api/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_github_api/providers/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: UserProvider()),
      ChangeNotifierProvider.value(value: RepoProvider()),
    ],
      child: MaterialApp(
        title: 'Github API',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}