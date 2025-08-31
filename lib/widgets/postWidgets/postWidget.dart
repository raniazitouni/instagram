import 'dart:ui';

import 'package:flutter/material.dart';
import 'postHeader.dart';
import 'postActions.dart';
import 'postImage.dart';
import 'postFooter.dart';

class PostWidget extends StatefulWidget {
  final String username;
  final String subname;
  final List<String> images;
  final String? caption;
  final String date;

  const PostWidget({
    Key? key,
    required this.username,
    required this.subname,
    required this.images,
    this.caption,
    required this.date,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostHeader(username: widget.username, subname: widget.subname),
        PostImage(images: widget.images),
        PostActions(),
        PostFooter(
          username: widget.username,
          caption: widget.caption,
          date: widget.date,
        ),
      ],
    );
  }
}
