import 'package:auto_animated/auto_animated.dart';
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
        child: LiveList(
      delay: Duration(milliseconds: 0),
      showItemInterval: Duration(milliseconds: 20),
      showItemDuration: Duration(milliseconds: 150),
      itemBuilder: (context, index, animation) {
        return buildAnimatedItem(context, index, animation);
      },
      itemCount: conversations.response.items.length,
    ));
  }

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    var cItem = conversations.response.items[index];
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      // And slide transition
      child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          // Paste you Widget
          child: ConversationItem(
            cItem: cItem,
            index: index,
          )),
    );
  }
}

// ListView.builder(
// itemBuilder: (BuildContext context, int index) {
// var cItem = conversations.response.items[index];
// return ConversationItem(
// cItem: cItem,
// index: index,
// );
// },
// itemCount: conversations.response.items.length,
// ),
