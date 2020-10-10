import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_vk_app/Models/ConverstationModel.dart';
import 'package:flutter_vk_app/pages/ConversationsPage.dart';
import 'package:flutter_vk_app/pages/DialogPage.dart';
import 'package:flutter_vk_app/supports/colors.dart';
import 'package:flutter_vk_app/supports/global_method.dart';

class ConversationItem extends StatefulWidget {
  final conItem cItem;
  final int index;
  const ConversationItem({Key key, @required this.cItem, @required this.index})
      : super(key: key);

  @override
  _ConversationItemState createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  Timer _timer;
  int _start = 5;
  bool isMe = null;
  bool isWrite = null;
  int id;
  int online = 0;
  String text, first_name = "", last_name = "", avatar = "";

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          print("HA HA HA");
          if (_start < 1) {
            isWrite = false;
            conversations.response.items[widget.index].isWrite = false;
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    id = widget.cItem.conversation.peer.id;
    isWrite = widget.cItem.isWrite == null ? false : widget.cItem.isWrite;
    text = widget.cItem.last_message.text;

    for (var item in conversations.response.profiles) {
      if (item.id == id) {
        first_name = item.first_name;
        last_name = item.last_name;
        online = item.online;
        avatar = item.photo_100;
        if (avatar.contains("https://vk.com/images/camera_100.png?ava=1")) {
          avatar = "no_ava";
        }
        break;
      }
    }

    if (isWrite) {
      setState(() {
        _start = 5;
        startTimer();
      });
    }

    if (widget.cItem.isMe == null) {
      widget.cItem.isMe = isMeFun(widget.cItem.last_message.from_id);
      isMe = isMeFun(widget.cItem.last_message.from_id);
    } else {
      isMe = widget.cItem.isMe;
    }

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DialogPage();
          },
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Stack(
              children: [
                avatar == "no_ava"
                    ? Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: designLightGray, width: 1)),
                        child: Center(
                          child: Text(
                            getInitials(first_name + " " + last_name),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 24),
                          ),
                        ))
                    : CircleAvatar(
                        backgroundImage: NetworkImage(avatar == ""
                            ? "https://vk.com/images/camera_200.png?ava=1"
                            : avatar),
                        radius: 28,
                      ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: online.toDouble(),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16)),
                          height: 14,
                          width: 14,
                        ))),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: AnimatedOpacity(
                        duration: Duration(milliseconds: 250),
                        opacity: isWrite ? 1 : 0,
                        child: Container(
                          height: 14,
                          width: 14,
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ))),
              ],
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          first_name == ""
                              ? "Vlad"
                              : first_name + " " + last_name,
                          style: TextStyle(
                              color: designBlack,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      Text(
                        "12:33",
                        style: TextStyle(
                            color: designGray,
                            fontWeight: FontWeight.w500,
                            fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    isMe
                        ? TextSpan(
                            text: !isWrite ? "Вы: " : "",
                            style: TextStyle(
                                color: designBlack,
                                fontWeight: FontWeight.w500,
                                fontSize: 10))
                        : TextSpan(
                            text: "",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.w500,
                                fontSize: 10)),
                    isWrite
                        ? TextSpan(
                            text: "Печатает...",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.w500,
                                fontSize: 10))
                        : TextSpan(
                            text: text != ""
                                ? text
                                : nameAttachment(widget.cItem.last_message
                                        .attachments.isNotEmpty
                                    ? widget
                                        .cItem.last_message.attachments[0].type
                                    : "ers"),
                            style: TextStyle(
                                color: (widget.cItem.last_message.attachments
                                                .length !=
                                            0) &&
                                        (text == "")
                                    ? Colors.amber
                                    : designGray,
                                fontWeight: FontWeight.w500,
                                fontSize: 10))
                  ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getInitials(String fullName) => fullName.isNotEmpty
    ? fullName.trim().split(" ").map((s) => s[0]).take(2).join()
    : '';
