import 'package:flutter/material.dart';
import 'package:flutter_vk_app/Models/ConverstationModel.dart';
import 'package:flutter_vk_app/supports/global_method.dart';
import 'package:flutter_vk_app/supports/variables.dart';

import 'ConversationItem.dart';

class ConversationContent extends StatefulWidget {
  final Converstation converstations;

  const ConversationContent({Key key, @required this.converstations})
      : super(key: key);

  @override
  _ConversationContentState createState() => _ConversationContentState();
}

class _ConversationContentState extends State<ConversationContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            conItem cItem = widget.converstations.response.items[index];

            bool isAttachment = false;
            bool isMe = false;
            bool isWrite = false;
            int id;
            int online = 0;
            String text, first_name = "", last_name = "", avatar = "";

            id = cItem.conversation.peer.id;
            text = cItem.last_message.text;
            isWrite = cItem.isWrite == null ? false : cItem.isWrite;
            isAttachment = cItem.isAttachment  == null ? false : cItem.isAttachment;

            for (var item in widget.converstations.response.profiles) {
              if (item.id == id) {
                first_name = item.first_name;
                last_name = item.last_name;
                online = item.online;
                avatar = item.photo_100;
                if (avatar
                    .contains("https://vk.com/images/camera_100.png?ava=1")) {
                  avatar = "no_ava";
                }
                break;
              }
            }

            if (text == "" && cItem.last_message.attachments.length != 0) {
              widget.converstations.response.items[index].isAttachment = true;
              isAttachment = true;
              text = nameAttachment(cItem.last_message.attachments[0].type);
            } else {
              widget.converstations.response.items[index].isAttachment = false;
              isAttachment = false;
            }

            widget.converstations.response.items[index].isMe = isMeFun(cItem.last_message.from_id);
            isMe = isMeFun(cItem.last_message.from_id);

            return ConversationItem(
              first_name: first_name,
              last_name: last_name,
              avatar: avatar,
              id: id,
              isWrite: isWrite,
              online: online,
              text: text,
              isMe: isMe,
              isAttachment: isAttachment,
            );
          },
          itemCount: widget.converstations.response.items.length,
        ),
      ),
    );
  }
}
