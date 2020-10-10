import 'package:flutter/material.dart';
import 'package:flutter_vk_app/pages/ConversationsPage.dart';

import 'ConversationItem.dart';

class ConversationContent extends StatefulWidget {
  const ConversationContent({Key key}) : super(key: key);

  @override
  _ConversationContentState createState() => _ConversationContentState();
}

class _ConversationContentState extends State<ConversationContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var cItem = conversations.response.items[index];
          return ConversationItem(
            cItem: cItem,
            index: index,
          );
        },
        itemCount: conversations.response.items.length,
      ),
    );
  }
}
