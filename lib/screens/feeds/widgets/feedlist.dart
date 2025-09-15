import 'package:flutter/material.dart';

/// Feed list with sample posts - Completely simplified
class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (index) {
        return Card(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Post header
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.purple[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person, color: Colors.purple[600]),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mentor ${index + 1}',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${index + 2}h • Mentor',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.more_horiz, color: Colors.grey[600]),
                  ],
                ),
                SizedBox(height: 12),
                // Post content
                Text(
                  'Quick tip: Practice coding for 30 minutes daily and build small projects. That beats long passive studying.',
                  style: TextStyle(fontSize: 14, height: 1.4),
                ),
                // Sample image for every 3rd post
                if (index % 3 == 0) ...[
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 40, color: Colors.grey[400]),
                          SizedBox(height: 8),
                          Text(
                            'Sample Image',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 12),
                // Post actions
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.thumb_up_outlined, size: 18),
                      label: Text('Like'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[600],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.chat_bubble_outline, size: 18),
                      label: Text('Comment'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[600],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.share_outlined, size: 18),
                      label: Text('Share'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class PostHeader extends StatelessWidget {
  final String author;
  final String time;
  const PostHeader({super.key, required this.author, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.purple[100],
          child: Icon(Icons.person, color: Colors.purple[600]),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(author, style: TextStyle(fontWeight: FontWeight.w700)),
              Text(
                '$time · Mentor',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
      ],
    );
  }
}

class PostActions extends StatelessWidget {
  const PostActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.thumb_up_outlined),
          label: Text('Like'),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.chat_bubble_outline),
          label: Text('Comment'),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.share_outlined),
          label: Text('Share'),
        ),
      ],
    );
  }
}
