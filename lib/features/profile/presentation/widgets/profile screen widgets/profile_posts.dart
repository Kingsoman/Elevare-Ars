import 'package:flutter/material.dart';

class ProfilePostsList extends StatelessWidget {
  final String profileId;
  const ProfilePostsList({super.key, required this.profileId});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch user posts using provider
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 3,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          title: Text("User Post #$index"),
          subtitle: const Text("This is a sample post content."),
          trailing: IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ),
      ),
    );
  }
}
