import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:instagram/widgets/postWidgets/postWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchSreen extends StatelessWidget {
  // Get a reference your Supabase client
  final supabase = Supabase.instance.client;

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await supabase.from('post').select('*, user(username)');
      final posts = (response as List<dynamic>).map((row) {
        return Post.fromJson({...row, 'username': row['user']['username']});
      }).toList();

      return posts;
    } catch (e, st) {
      debugPrint('Error fetching posts: $e\n$st');
      throw Exception('Failed to fetch posts: $e');
    }
  }

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
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No posts yet"));
          } else {
            final posts = snapshot.data ?? [];
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostWidget(post: post);
              },
            );
          }
        },
      ),
    );
  }
}
