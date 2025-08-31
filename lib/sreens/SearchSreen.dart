import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:instagram/widgets/postWidgets/postWidget.dart';

class SearchSreen extends StatelessWidget {
  final List<Map<String, dynamic>> posts = [
    {
      "username": "aacoding_tips",
      "subname": "Suggested for you",
      "images": [
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
      ],
      "caption": "Beautiful VS Code themes all programmers should know",
      "date": "18 August",
    },
    {
      "username": "aacoding_tips",
      "subname": "Suggested for you",
      "images": [
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
      ],
      "caption": "Beautiful VS Code themes all programmers should know",
      "date": "18 August",
    },
  ];

  SearchSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostWidget(
          username: post['username'],
          subname: post['subname'],
          images: List<String>.from(post['images']),
          caption: post['caption'],
          date: post['date'],
        );
      },
    );
  }
}
