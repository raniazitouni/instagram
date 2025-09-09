import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Comment {
  final int id;
  final String username;
  final String comment;
  final String date;
  final int commentLikesNumber;
  final bool isCommentLiked;

  const Comment({
    required this.id,
    required this.username,
    required this.comment,
    required this.date,
    required this.commentLikesNumber,
    required this.isCommentLiked,
  });

  factory Comment.fromJson(Map<String, dynamic> json, int currentUserId) {
    final likes = json['commentlike'] as List? ?? [];
    final likesCount = likes.length;
    final isLiked = likes.any(
      (like) => like['user_id'].toString() == currentUserId,
    );

    return Comment(
      id: json['id'],
      username: json['user']?['username'] ?? 'Unknown',
      comment: json['comment'] ?? '',
      date: json['date']?.toString() ?? '',
      commentLikesNumber: likesCount,
      isCommentLiked: isLiked,
    );
  }
}

class PostComment extends StatefulWidget {
  final int postId;
  final int currentUserId;
  PostComment({super.key, required this.postId, required this.currentUserId});

  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  TextEditingController _controller = TextEditingController();

  final supabase = Supabase.instance.client;

  Future<List<Comment>> fetchComments(int postId, int currentUserId) async {
    try {
      final response = await supabase
          .from('comment')
          .select('''
            id,
            comment,
            date,
            user:user_id(username, avatar_url),
            commentlike!left ( user_id )
          ''')
          .eq('post_id', postId)
          .order('date', ascending: false);

      final comments = (response as List<dynamic>)
          .map((row) => Comment.fromJson(row, currentUserId))
          .toList();

      return comments;
    } catch (e, st) {
      debugPrint('Error fetching Comments: $e\n$st');
      throw Exception('Failed to fetch Comments: $e');
    }
  }

  Future<void> addComment(int postId, String text, int user_id) async {
    try {
      await supabase.from('comment').insert({
        'comment': text,
        'post_id': postId,
        'user_id': user_id,
      });
    } catch (e, st) {
      debugPrint('Error inserting comment: $e\n$st');
      throw Exception('Failed to add comment: $e');
    }
  }

  Future<void> toggleCommentLike(int commentId) async {
    final userId = widget.currentUserId;

    try {
      // Check if like already exists
      final existing = await supabase
          .from('commentlike')
          .select()
          .eq('comment_id', commentId)
          .eq('user_id', userId);

      if (existing.isNotEmpty) {
        // Unlike (delete row)
        await supabase
            .from('commentlike')
            .delete()
            .eq('comment_id', commentId)
            .eq('user_id', userId);
      } else {
        // Like (insert new row)
        await supabase.from('commentlike').insert({
          'comment_id': commentId,
          'user_id': userId,
        });
      }
    } catch (e, st) {
      debugPrint("Error toggling like: $e\n$st");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(height: 10),
                    Text(
                      "Comments",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // comments list
                    Expanded(
                      child: FutureBuilder<List<Comment>>(
                        future: fetchComments(
                          widget.postId,
                          widget.currentUserId,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("Error: ${snapshot.error}"),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(child: Text("No Comments yet"));
                          } else {
                            final comments = snapshot.data ?? [];
                            return ListView.builder(
                              controller: scrollController,
                              itemCount: comments.length,

                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    comments[index].username,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    comments[index].date,
                                                    style: const TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Text(
                                                comments[index].comment,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print("Text tapped!");
                                                  // do something here
                                                },
                                                child: Text(
                                                  "Reply",
                                                  style: const TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await toggleCommentLike(
                                                comments[index].id,
                                              );
                                              setState(
                                                () {},
                                              ); // refresh FutureBuilder
                                            },
                                            child: Icon(
                                              comments[index].isCommentLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color:
                                                  comments[index].isCommentLiked
                                                  ? Colors.red[600]
                                                  : Colors.white60,
                                              size: 28,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            comments[index].commentLikesNumber
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),

                    // input + send
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Write a comment...",
                              hintStyle: TextStyle(color: Colors.white54),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white10,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white30,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  if (_controller.text.trim().isNotEmpty) {
                                    final text = _controller.text.trim();

                                    await addComment(
                                      widget.postId,
                                      text,
                                      widget.currentUserId,
                                    );
                                    _controller.clear();

                                    setState(() {}); // refresh FutureBuilder
                                  }
                                },

                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
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
  }
}
