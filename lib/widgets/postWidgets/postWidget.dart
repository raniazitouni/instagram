import 'dart:ui';

import 'package:flutter/material.dart';
import 'postHeader.dart';
import 'postActions.dart';
import 'postImage.dart';
import 'postFooter.dart';

class Post {
  final String username;
  final String subname;
  final List<String> images;
  final String? caption;
  final String date;
  final bool isFollow;
  final bool isLiked;
  final bool isSaved;
  final int likesNumber;
  final int commentNumber;
  final int repostNumber;
  final int shareNumber;

  const Post({
    required this.username,
    required this.subname,
    required this.images,
    this.caption,
    required this.date,
    required this.isFollow,
    required this.isLiked,
    required this.isSaved,
    required this.commentNumber,
    required this.likesNumber,
    required this.repostNumber,
    required this.shareNumber,
  });
}

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostHeader(
          username: widget.post.username,
          subname: widget.post.subname,
          isFollow: widget.post.isFollow,
        ),
        PostImage(images: widget.post.images),
        PostActions(
          username: widget.post.username,
          isLiked: widget.post.isLiked,
          isSaved: widget.post.isSaved,
          commentNumber: widget.post.commentNumber,
          likesNumber: widget.post.likesNumber,
          shareNumber: widget.post.shareNumber,
          repostNumber: widget.post.repostNumber,
        ),
        PostFooter(
          username: widget.post.username,
          caption: widget.post.caption,
          date: widget.post.date,
        ),
      ],
    );
  }
}
