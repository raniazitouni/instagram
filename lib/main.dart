import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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

        body: PostWidget(
          username: "aacoding_tips",
          subname: "Suggested for you",
          images: [
            "assets/images/insta.jpg",
            "assets/images/insta.jpg",
            "assets/images/insta.jpg",
          ],
          date: "18 august",
          caption: "beutifull vs code themes all programmers should know",
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined),
              label: "Reels",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop_outlined),
              label: "Shop",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

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

class PostHeader extends StatelessWidget {
  final String username;
  final String subname;

  const PostHeader({Key? key, required this.username, required this.subname})
    : super(key: key);

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
                    username,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subname,
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
                  print("follow");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 55, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  overlayColor: Colors.white60,
                ),
                child: Text(
                  "Follow",
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

class PostImage extends StatefulWidget {
  final List<String> images;
  const PostImage({super.key, required this.images});

  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //the images
        SizedBox(
          height: 500,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                widget.images[index],
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          ),
        ),

        // the dots
        Container(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                width: currentPage == index ? 10 : 6,
                height: currentPage == index ? 10 : 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPage == index ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PostActions extends StatefulWidget {
  const PostActions({super.key});

  @override
  State<PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  bool isLiked = false;
  bool isSaved = false;
  int likesNumber = 1405;
  int commentNumber = 15;
  int repostNumber = 14;
  int shareNumber = 514;

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
                      print("comment");
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

class PostFooter extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  username,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    caption ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Text(
              date,
              style: TextStyle(
                color: Colors.white30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
