import 'package:flutter/material.dart';

class User{
  String username='';
  String imageUrl='';
  int followers=0;
  int followings=0;
  int public_repo=0;
  String joined_data='';

  User({
    required this.username,
    required this.imageUrl,
    required this.followers,
    required this.followings,
    required this.public_repo,
    required this.joined_data
  });
}