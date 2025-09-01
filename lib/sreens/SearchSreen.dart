import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:instagram/widgets/postWidgets/postWidget.dart';



class SearchSreen extends StatelessWidget {
  final List<Post> posts = [
    Post(
       username: "aacoding_tips",
       subname: "Suggested for you",
       images: [
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
      ],
       caption: "Beautiful VS Code themes all programmers should know",
       date: "18 August",
       isFollow: false,
       isLiked: false,
       isSaved : false,
       likesNumber :  1405,
       commentNumber :  15,
       repostNumber : 14,
       shareNumber : 514,
    ),
    Post(
      username: "aacoding_tips",
      subname: "Suggested for you",
      images: [
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
        "assets/images/insta.jpg",
      ],
      caption: "Beautiful VS Code themes all programmers should know",
      date: "18 August",
      isFollow: true,
      isLiked: false,
       isSaved : false,
       likesNumber :  1405,
       commentNumber :  15,
       repostNumber : 14,
       shareNumber : 514,
      
    ),
    
  ];

  SearchSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          highlightColor: Colors.grey.withOpacity(0.2),
        ),
        title: const Text(
          "Explore",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostWidget( post: post,
          );
        },
      ),
    );
  }
}
