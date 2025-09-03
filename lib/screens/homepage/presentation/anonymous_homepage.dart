import 'package:elevare_ars/core/config/themes/darkmode_switch_widget.dart';
import 'package:elevare_ars/screens/homepage/presentation/anonymous_login/anonymouspage.dart';
import 'package:flutter/material.dart';
import 'package:elevare_ars/core/config/responsive%20layout/response_layout.dart';

class AnonymousHomepage extends StatelessWidget {
  const AnonymousHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        titleSpacing: 12,
        title: Row(
          children: [
            // App logo / name
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'EA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text('Elevare Ars', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(width: 20),

            // Search
            Expanded(
              child: Container(
                height: 42,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search mentors, topics, posts',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
            tooltip: 'Notifications',
          ),
          IconButton(
            icon: Icon(Icons.message_outlined),
            onPressed: () {},
            tooltip: 'Messages',
          ),
          SizedBox(width: 8),
          // Fixed: Added error handling for network image
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[600]),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ResponsiveLayout(
            leftColumn: Column(
              children: [
                ProfileCard(),
                SizedBox(height: 16),
                SimpleMenuCard(),
                ThemeSwitchTile(),
                ListTile(
                  title: Text('go to mentor screen'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    );
                  },
                ),
              ],
            ),
            centerColumn: Column(
              children: [CreatePostCard(), SizedBox(height: 12), FeedList()],
            ),
            rightColumn: Column(
              children: [
                WhoToFollowCard(),
                SizedBox(height: 12),
                TrendingCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Left profile summary - Fixed with placeholder avatar
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            // Fixed: Using CircleAvatar with icon instead of network image
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.blue[100],
              child: Icon(Icons.person, size: 40, color: Colors.blue[600]),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Somto Onyeagusi',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(height: 4),
                Text(
                  'Computer Science Student • University',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(minimumSize: Size(100, 36)),
                  child: Text('View profile'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple left menu
class SimpleMenuCard extends StatelessWidget {
  SimpleMenuCard({super.key});
  final items = [
    {'icon': Icons.bookmark_border, 'label': 'My Courses'},
    {'icon': Icons.event_note, 'label': 'Events'},
    {'icon': Icons.group_outlined, 'label': 'Groups'},
    {'icon': Icons.analytics_outlined, 'label': 'Insights'},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: items.map((it) {
          return ListTile(
            leading: Icon(it['icon'] as IconData),
            title: Text(it['label'] as String, style: TextStyle(fontSize: 14)),
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }
}

/// Create post card (center top) - Corrected code
class CreatePostCard extends StatelessWidget {
  const CreatePostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, color: Colors.blue[600]),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(),
                      hintText: "Share an update, question, or request advice",
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Change the alignment of the Row to push the buttons to the ends
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.photo_camera_outlined, size: 20),
                      label: Text('Photo'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[600],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.videocam_outlined, size: 20),
                      label: Text('Video'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                // Use a SizedBox to wrap the ElevatedButton and give it a bounded width
                SizedBox(
                  width: 80, // You can adjust this width
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Post'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

/// Right: who to follow - Simplified
class WhoToFollowCard extends StatelessWidget {
  const WhoToFollowCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.blue, Colors.orange];

    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'People you may want to follow',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            SizedBox(height: 16),
            // Generate 3 suggestion items
            ...List.generate(3, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: index == 2 ? 0 : 12),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(26),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person, color: colors[index]),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pro ${index + 1}',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Industry Mentor',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: Size(70, 32),
                      ),
                      child: Text('Follow', style: TextStyle(fontSize: 10)),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// Right: trending topics
class TrendingCard extends StatelessWidget {
  TrendingCard({super.key});
  final trends = [
    'AI in Healthcare',
    'Portfolio Tips',
    'Interview Prep',
    'UX Design',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trending', style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            ...trends.map(
              (t) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, size: 18),
                    SizedBox(width: 8),
                    Expanded(child: Text(t)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
