import 'package:flutter/material.dart';

class CreatePostCard extends StatelessWidget {
  const CreatePostCard({super.key});

  void _openPostEditor(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      // ✅ Fullscreen Page (mobile/tablet)
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => _PostEditorPage(controller: controller),
        ),
      );
    } else {
      // ✅ Center Dialog (desktop/web)
      showDialog(
        context: context,
        builder: (_) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.all(16),
          child: _PostEditorContent(controller: controller),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),

            // Fake textfield (read-only, triggers editor)
            Expanded(
              child: GestureDetector(
                onTap: () => _openPostEditor(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Text(
                    "Share an update, question, or request advice",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================
// Post Editor for MOBILE (page)
// ============================
class _PostEditorPage extends StatelessWidget {
  final TextEditingController controller;
  const _PostEditorPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a Post"),
        actions: [
          TextButton(
            onPressed: () {
              String content = controller.text.trim();
              if (content.isNotEmpty) {
                debugPrint("Posted (mobile): $content");
                Navigator.pop(context);
              }
            },
            child: const Text("Post"),
          ),
        ],
      ),
      body: _PostEditorContent(controller: controller),
    );
  }
}

// ============================
// Shared Editor Content
// ============================
class _PostEditorContent extends StatelessWidget {
  final TextEditingController controller;
  const _PostEditorContent({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 500, // Dialog width on desktop
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            maxLines: 6,
            decoration: const InputDecoration(
              hintText: "Share an update, question, or request advice",
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 16),

          // Media + Post actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.photo_camera_outlined),
                    tooltip: "Add photo",
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.videocam_outlined),
                    tooltip: "Add video",
                  ),
                ],
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    String content = controller.text.trim();
                    if (content.isNotEmpty) {
                      print("Posted: $content");
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Post"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
