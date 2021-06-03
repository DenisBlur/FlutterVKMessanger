import 'package:flutter/material.dart';
import 'package:flutter_vk_app/GlobalWidget/FadeCircleAvatar.dart';

class MessageItem extends StatelessWidget {

  final String message, time, avatar;
  final bool lastMessage, isMe;

  const MessageItem({this.message, this.time, this.avatar, this.lastMessage, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(bottom: lastMessage? 24: 0, right: 16, left: 16), child: Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: lastMessage? 8 : 2),
          padding: EdgeInsets.all(16),
          decoration: isMe ? BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(77, 155, 144, 1),
              Color.fromRGBO(12, 101, 89, 1),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(4),
          ) : BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4),),
          child: Text(
            message,
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
        lastMessage ? isMe ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              time,
              style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w100
              ),
            ),
            SizedBox(width: 6,),
            FadeCircleAvatar(
              radius: 8,
              imageUrl: avatar,
            )
          ],
        ) : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeCircleAvatar(
              radius: 8,
              imageUrl: avatar,
            ),
            SizedBox(width: 6,),
            Text(
              time,
              style: TextStyle(
                  fontSize: 8,
                fontWeight: FontWeight.w100
              ),
            ),
          ],
        ) : SizedBox()
      ],));
  }
}
