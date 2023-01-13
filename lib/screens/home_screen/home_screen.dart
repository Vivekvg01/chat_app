import 'package:chat_app/Functions/firebase_functions.dart';
import 'package:chat_app/screens/group_chat_screen/group_chat_screen.dart';
import 'package:chat_app/screens/home_screen/chat_room.dart';
import 'package:chat_app/const_values/const_values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;

  bool isLoading = false;

  final TextEditingController _search = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //online
      setStatus("online");
    } else {
      //offile
      setStatus("offline");
    }
  }

  //Logout Popup
  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure wanted to logout?'),
      actions: [
        //yes
        ElevatedButton(
          onPressed: () => logOut(context),
          child: const Text('Yes'),
        ),
        //No
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 0.0,
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
            onPressed: () => showDialog(
                context: context,
                builder: (builder) {
                  return _buildPopupDialog(context);
                }),
            icon: const Icon(
              Icons.logout,
              color: Colors.grey,
              size: 24,
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
                      : const SizedBox(),
                  // StreamBuilder(
                  //   stream: _firestore
                  //       .collection('users')
                  //       .doc()
                  //       .collection('message')
                  //       .snapshots(),
                  //   builder: (context, AsyncSnapshot snapshot) {
                  //    if (snapshot.hasData) {
                  //       if (snapshot.data.docs.length < 1) {
                  //         return const Center(
                  //           child: Text("No Chats found"),
                  //         );
                  //       }
                  //         return ListView.builder(
                  //           itemCount: snapshot.data.docs.length,
                  //           itemBuilder: ((context, index) {
                  //             var userId = snapshot.data.docs[index];
                  //             return ListTile(
                  //               title: Text(userMap!['name']),
                  //               subtitle: Text(userMap!['email']),
                  //             );
                  //           }),
                  //         );
                  //       }
                  //     }
                
                  // )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: (() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const GroupChatHomeScreen(),
            ),
          );
        }),
        child: const Icon(Icons.groups),
      ),
    );
  }
}
