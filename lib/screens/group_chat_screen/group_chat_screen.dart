import 'package:chat_app/screens/group_chat_screen/group_chat_rrom.dart';
import 'package:flutter/material.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Groups'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Create group",
        child: const Icon(Icons.create),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => GroupChatRoom(
                    groupChatId: 'groupChatId', groupName: 'groupName'),
              ),
            ),
            leading: const Icon(Icons.group),
            title: Text('Group $index'),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
