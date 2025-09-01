import 'dart:ui';

import 'package:flutter/material.dart';

class PostActions extends StatefulWidget {
  final String username;
  final bool isLiked;
  final bool isSaved;
  final int likesNumber;
  final int commentNumber;
  final int repostNumber;
  final int shareNumber;

  const PostActions({
    super.key,
    required this.username,
    required this.isLiked,
    required this.isSaved,
    required this.commentNumber,
    required this.likesNumber,
    required this.repostNumber,
    required this.shareNumber,
  });

  @override
  State<PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  late bool isLiked = false;
  late bool isSaved = false;
  late int likesNumber = 1405;
  late int commentNumber = 15;
  late int repostNumber = 14;
  late int shareNumber = 514;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    isSaved = widget.isSaved;
    commentNumber=widget.commentNumber;
    repostNumber=widget.repostNumber;
    shareNumber=widget.shareNumber;
    likesNumber=widget.likesNumber;
  }

  // comments
  final List<Map<String, dynamic>> comments = [
    {"username": "xk345", "comment": "Nice post!"},
    {"username": "xiaoqi", "comment": "Love this"},
  ];

  void _openComments(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setModalState) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // drag handle
                        Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // comments list
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  comments[index]["username"],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  comments[index]["comment"],
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              );
                            },
                          ),
                        ),

                        Divider(color: Colors.grey[800]),

                        // input + send
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: "Write a comment...",
                                  hintStyle: TextStyle(color: Colors.white54),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (_controller.text.trim().isNotEmpty) {
                                  setModalState(() {
                                    comments.add({
                                      "username": widget.username,
                                      "comment": _controller.text.trim(),
                                    });
                                  });
                                  setState(() {
                                    commentNumber++;
                                  });
                                  _controller.clear();
                                }
                              },
                              icon: const Icon(Icons.send, color: Colors.blue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
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
