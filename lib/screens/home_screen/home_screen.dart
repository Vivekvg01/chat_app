import 'package:chat_app/Functions/firebase_functions.dart';
import 'package:chat_app/const_values/const_values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                  //const ChatTileWidget(),
                  userMap != null
                      ? ListTile(
                          leading: const CircleAvatar(),
                          title: Text(userMap!['name']),
                          subtitle: Text(userMap!['email']),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
    );
  }
}
