import 'package:flutter/material.dart';
import 'package:flutter_vk_app/pages/DialogPage.dart';
import 'package:flutter_vk_app/supports/colors.dart';

class ConversationItem extends StatefulWidget {
  final String text, first_name, last_name, avatar;
  final bool isWrite, isMe, isAttachment;
  final int id, online;

  const ConversationItem(
      {Key key,
      @required this.text,
      @required this.first_name,
      @required this.last_name,
      @required this.avatar,
      @required this.isWrite,
      @required this.id,
      @required this.online,
      @required this.isMe,
      @required this.isAttachment})
      : super(key: key);

  @override
  _ConversationItemState createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  @override
  Widget build(BuildContext context) {
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
                widget.avatar == "no_ava"
                    ? Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: designLightGray, width: 1)),
                        child: Center(
                          child: Text(
                            getInitials(
                                widget.first_name + " " + widget.last_name),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 24),
                          ),
                        ))
                    : CircleAvatar(
                        backgroundImage: NetworkImage(widget.avatar),
                        radius: 28,
                      ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: widget.isWrite ? 1 : 0,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(16)),
                          height: 14,
                          width: 14,
                        ))),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: widget.online.toDouble(),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16)),
                          height: 14,
                          width: 14,
                        )))
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
                          widget.first_name == ""
                              ? "Vlad"
                              : widget.first_name + " " + widget.last_name,
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
                    widget.isMe
                        ? TextSpan(
                            text: "Вы: ",
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
                    TextSpan(
                        text: widget.text,
                        style: TextStyle(
                            color: widget.isAttachment ? Colors.amber : designGray,
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
