import 'package:flutter/material.dart';
import '../widgets/chat_list_tile.dart';
class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
    children: [
      ChatListTile(),
      Divider(),
      ChatListTile(),
      Divider(),
      ChatListTile(),
      Divider(),
      ChatListTile(),
      Divider(),
      ChatListTile(),
      Divider(),
      ChatListTile(),
    ],
    );
  }
}
