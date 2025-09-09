import 'dart:ui';

import 'package:flutter/material.dart';
import 'postComment.dart';


class PostActions extends StatefulWidget {
  final String username;
  final bool isLiked;
  final bool isSaved;
  final int likesNumber;
  final int commentNumber;
  final int repostNumber;
  final int shareNumber;
  final int postId;
  final int currentUserId;

  const PostActions({
    super.key,
    required this.username,
    required this.isLiked,
    required this.isSaved,
    required this.commentNumber,
    required this.likesNumber,
    required this.repostNumber,
    required this.shareNumber,
    required this.postId,
    required this.currentUserId,
    
  });

  @override
  State<PostActions> createState() => _PostActionsState();


}

class _PostActionsState extends State<PostActions> {
  late bool isLiked;
  late bool isSaved;
  late int likesNumber;
  late int commentNumber;
  late int repostNumber;
  late int shareNumber;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    isSaved = widget.isSaved;
    commentNumber = widget.commentNumber;
    repostNumber = widget.repostNumber;
    shareNumber = widget.shareNumber;
    likesNumber = widget.likesNumber;
  }


  // // comments
  // final List<Comment> comments = [
  //   Comment(
  //     username: "xk345",
  //     comment: "Nice post!",
  //     date: "1w",
  //     CommentlikesNumber: 1,
  //     isCommentLiked: false,
  //   ),
  //   Comment(
  //     username: "xiaoqi",
  //     comment: "Love this",
  //     date: "2w",
  //     CommentlikesNumber: 2,
  //     isCommentLiked: false,
  //   ),
  // ];

  void _openComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return PostComment(postId : widget.postId,currentUserId: widget.currentUserId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // the left side
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //like
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isLiked) {
                          likesNumber--;
                        } else {
                          likesNumber++;
                        }
                        isLiked = !isLiked;
                      });
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red[600] : Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 2),
                  Text(
                    likesNumber.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 7),
              //comment
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _openComments(context);
                    },
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 2),
                  Text(
                    commentNumber.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 7),
              //repost
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("repost");
                    },
                    child: Icon(Icons.repeat, color: Colors.white, size: 28),
                  ),
                  SizedBox(width: 2),
                  Text(
                    repostNumber.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 7),
              //share
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("share");
                    },
                    child: Icon(Icons.send, color: Colors.white, size: 28),
                  ),
                  SizedBox(width: 2),
                  Text(
                    shareNumber.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),

          //the right side
          GestureDetector(
            onTap: () {
              setState(() {
                isSaved = !isSaved;
              });
            },
            child: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
