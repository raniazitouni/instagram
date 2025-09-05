import 'dart:ui';

import 'package:flutter/material.dart';

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
              return Image.network(
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
