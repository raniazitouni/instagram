import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PostFooter extends StatefulWidget {
  final String username;
  final String? caption;
  final String date;

  const PostFooter({
    Key? key,
    required this.username,
    this.caption,
    required this.date,
  }) : super(key: key);

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  bool isExpanded = false;
  final int maxWords = 5;

  @override
  Widget build(BuildContext context) {
    String fullCaption = widget.caption ?? "";
    List<String> words = fullCaption.split(" ");

    bool shouldShowMore = words.length > maxWords;

     String visibleText = !isExpanded && shouldShowMore
        ? words.take(maxWords).join(" ") + "..."
        : fullCaption;

    return Container(
      width: double.infinity, 
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text : widget.username + " ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
               ),
               TextSpan(
                  text: visibleText,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                if (!isExpanded && shouldShowMore)
                  TextSpan(
                    text: " more",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          isExpanded = true;
                        });
                      },
                  ),
            ],)
          ),
          Text(
            widget.date,
            style: TextStyle(
              color: Colors.white30,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
