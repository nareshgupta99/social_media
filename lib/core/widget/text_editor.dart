import 'package:flutter/material.dart';

class PostEditor extends StatefulWidget {
  TextEditingController controller;

  PostEditor({super.key, required this.controller});

  @override
  State<PostEditor> createState() => _PostEditorState();
}

class _PostEditorState extends State<PostEditor> {
  static const int maxLength = 500;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.controller,
            maxLines: null,
            minLines: 1,
            maxLength: maxLength,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              hintText: "What's on your mind?",
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
              counterStyle: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
