import 'dart:ui';

import 'package:flutter/material.dart';

class PostHeader extends StatefulWidget {
  final String username;
  final String subname;
  final bool isFollow;

  const PostHeader({Key? key, required this.username, required this.subname , required this.isFollow})
    : super(key: key);

  @override
  State<PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<PostHeader> {
  late bool isFollow;

  @override
  void initState() {
    super.initState();
    isFollow = widget.isFollow;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //the profile picture + username
          Row(
            children: [
              CircleAvatar(child: const Icon(Icons.person)),
              const SizedBox(width: 10), // spacing between avatar & text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.username,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    widget.subname,
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          //the follow button + more icon
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isFollow = !isFollow;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 55, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  overlayColor: Colors.white60,
                ),
                child: Text(
                  isFollow ? "Following" : "Follow",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  print("more");
                },
                icon: Icon(Icons.more_vert_outlined, color: Colors.white),
                highlightColor: Colors.grey.withOpacity(0.2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
