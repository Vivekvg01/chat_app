import 'package:chat_app/Functions/firebase_functions.dart';
import 'package:chat_app/chat_room_screen/chat_room.dart';
import 'package:chat_app/const_values/const_values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userMap;

  bool isLoading = false;

  final TextEditingController _search = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >=
        user2[0].toLowerCase().codeUnits[0]) {
      return "${user1[0].toLowerCase().codeUnits[0]}${user2[0].toLowerCase().codeUnits[0]}";
    } else {
      return "${user2[0].toLowerCase().codeUnits[0]}${user1[0].toLowerCase().codeUnits[0]}";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where(
          'email',
          isEqualTo: _search.text,
        )
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Chats',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 35,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => logOut(context),
            icon: const Icon(
              Icons.logout,
              color: Colors.grey,
              size: 24,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Colors.grey,
                size: 22,
              ),
            ),
          ),
          sizedBoxWidth(10),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  //search textfeild
                  SizedBox(
                    height: 45,
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(),
                        hintText: "Search",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                              BorderSide(width: 3, color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ),
                  sizedBoxHeight(10),
                  ElevatedButton(
                    onPressed: onSearch,
                    child: const Text('search'),
                  ),
                  userMap != null
                      ? ListTile(
                          onTap: () {
                            String roomId = chatRoomId(
                              _auth.currentUser!.displayName!,
                              userMap!['name'],
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChatRoom(
                                  chatRoomId: roomId,
                                  userMap: userMap!,
                                ),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            radius: 26,
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwHTZ8zi4vN4YAWw0jCcNGgfMsIN2zEPSF0vUhphE26QFXDHi3kKozZSMISp6hEKwPwvM&usqp=CAU',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(userMap!['name']),
                          subtitle: Text(userMap!['email']),
                        )
                      : Container(),
                ],
              ),
            ),
    );
  }
}
