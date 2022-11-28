import 'package:chat_app/const_values/const_values.dart';
import 'package:flutter/material.dart';

class ViewChatScreen extends StatelessWidget {
  const ViewChatScreen({
    super.key,
    required this.title,
    required this.imgUrl,
  });

  final String title;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(title), 
        elevation: 0,
      ),
    );
  }
}
