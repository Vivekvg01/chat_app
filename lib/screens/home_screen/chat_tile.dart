// import 'package:chat_app/screens/view_chat_screen/view_chat_screen.dart';
// import 'package:flutter/material.dart';

// class ChatTileWidget extends StatelessWidget {
//   const ChatTileWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       physics: const ClampingScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (ctx, index) {
      //   return ListTile(
      //     leading: CircleAvatar(
      //       radius: 26,
      //       child: Image.network(
      //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwHTZ8zi4vN4YAWw0jCcNGgfMsIN2zEPSF0vUhphE26QFXDHi3kKozZSMISp6hEKwPwvM&usqp=CAU',
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     title: Text('Person $index'),
      //     trailing: CircleAvatar(
      //       radius: 10,
      //       child: Text(
      //         index.toString(),
      //         style: const TextStyle(fontSize: 10),
      //       ),
      //     ),
      //     onTap: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (_) {
      //             return ViewChatScreen(
      //               title: 'Person $index',
      //               imgUrl:
      //                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwHTZ8zi4vN4YAWw0jCcNGgfMsIN2zEPSF0vUhphE26QFXDHi3kKozZSMISp6hEKwPwvM&usqp=CAU',
      //             );
      //           },
      //         ),
      //       );
      //     },
      //   );
      // },
//       separatorBuilder: (_, __) => const Divider(
//         thickness: 1,
//         indent: 20,
//       ),
//       itemCount: 20,
//     );
//   }
// }
