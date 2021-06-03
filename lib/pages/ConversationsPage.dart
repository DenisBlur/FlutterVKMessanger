import 'dart:convert';
import 'dart:io';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vk_app/Models/ConverstationModel.dart';
import 'package:flutter_vk_app/Models/LongPoll/LongPollWrapper.dart';
import 'package:flutter_vk_app/Widgets/ConversationContent.dart';
import 'package:flutter_vk_app/supports/colors.dart';
import 'package:flutter_vk_app/supports/global_method.dart';
import 'package:flutter_vk_app/supports/variables.dart';
import 'package:http/http.dart' as http;

class ConversationsPage extends StatefulWidget {
  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

Converstation conversations;
LongPollWrapper _longPollWrapper;
int timer = 0;

class _ConversationsPageState extends State<ConversationsPage> {
  Future<void> GetMainDataLongPoll() async {
    var url = API_URL +
        "messages.getLongPollServer?access_token=" +
        TOKEN +
        VERSION_API;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      _longPollWrapper = LongPollWrapper.fromJson(map);
    }
  }

  Stream<LongPollAnswer> getLongPoll() async* {
    var url;
    while (true) {
      if (_longPollWrapper == null) {
        await GetMainDataLongPoll();
      } else {
        if (timer == 0) {
          var url_main = API_URL +
              "messages.getLongPollServer?access_token=" +
              TOKEN +
              VERSION_API;
          var response_main = await http.get(url_main);
          if (response_main.statusCode == 200) {
            Map<String, dynamic> map_main =
            jsonDecode(response_main.body.toString());
            _longPollWrapper = LongPollWrapper.fromJson(map_main);
          }
          String server = _longPollWrapper.response.server,
              key = _longPollWrapper.response.key,
              ts = _longPollWrapper.response.ts.toString();
          url = "http://" +
              server +
              "?act=a_check&key=" +
              key +
              "&wait=25&mode=2&ts=" +
              ts +
              "&version=3";
          timer = 5;
        } else {
          timer--;
        }
        var response = await http.get(url);
        Map<String, dynamic> map = jsonDecode(response.body.toString());
        LongPollAnswer answer = LongPollAnswer.fromJson(map);
        yield answer;
      }
    }
  }

  Future<void> GetConverstations() async {
    var url = API_URL +
        "messages.getConversations?count=20&filter=all&extended=1&access_token=" +
        TOKEN +
        VERSION_API;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      conversations = Converstation.fromJson(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBarWidget(
              height: 56,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_rounded), label: "Messenger"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: "Profile")
              ],
            ),
            backgroundColor: Colors.white,
            body: FutureBuilder(
              // ignore: missing_return
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                  case ConnectionState.active:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    return StreamBuilder(
                      initialData: false,
                      stream: getLongPoll(),
                      key: UniqueKey(),
                      builder:
                          // ignore: missing_return
                          (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            break;
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            var answer = snapshot.data;
                            if (answer != false) {
                              for (var update in answer.updates) {
                                switch (update[0]) {
                                  case 4:
                                    for (var i = 0;
                                        i < conversations.response.items.length;
                                        i++) {
                                      var item =
                                          conversations.response.items[i];
                                      item.isWrite = false;
                                      item.last_message.attachments.clear();
                                      if (item.conversation.peer.id
                                              .toString() ==
                                          update[3].toString()) {
                                        item.conversation.in_read = update[1];
                                        if (update[2] == 51) {
                                          item.isMe = true;
                                        } else {
                                          item.isMe = false;
                                        }
                                        item.last_message.text =
                                            update[5].toString();
                                        if (update[7].toString() != "{}") {
                                          item.last_message.attachments.add(
                                              new conAttachment(
                                                  update[7]["attach1_type"]));
                                        }
                                        conversations.response.items[i] = item;
                                        conversations.response.items
                                            .removeAt(i);
                                        conversations.response.items
                                            .insert(0, item);
                                        break;
                                      }
                                    }
                                    break;
                                  case 6:
                                    print("UPDATEEEEEEE 6:" + update.toString());
                                    for (var i = 0;
                                    i < conversations.response.items.length;
                                    i++) {
                                      var item =
                                      conversations.response.items[i];
                                      if (item.conversation.peer.id
                                          .toString() ==
                                          update[1].toString()) {
                                        item.conversation.out_read = update[2];
                                        conversations.response.items[i] = item;
                                        break;
                                      }
                                    }
                                    break;
                                  case 7:
                                    print("UPDATEEEEEEE 7:" + update.toString());
                                    for (var i = 0;
                                        i < conversations.response.items.length;
                                        i++) {
                                      var item =
                                          conversations.response.items[i];
                                      if (item.conversation.peer.id
                                              .toString() ==
                                          update[1].toString()) {
                                        item.conversation.out_read = update[2];
                                        conversations.response.items[i] = item;
                                        break;
                                      }
                                    }
                                    break;
                                  case 8:
                                  case 9:
                                    int online_date = update[0] == 8 ? 1 : 0;
                                    int id_date = update[1] * -1;
                                    for (var i = 0;
                                        i <
                                            conversations
                                                    .response.items.length -
                                                1;
                                        i++) {
                                      var item =
                                          conversations.response.profiles[i];
                                      if (item.id == id_date) {
                                        item.online = online_date;
                                        conversations.response.profiles[i] =
                                            item;
                                      }
                                    }
                                    break;
                                  case 61:
                                    for (var i = 0;
                                        i < conversations.response.items.length;
                                        i++) {
                                      var item =
                                          conversations.response.items[i];
                                      item.last_message.attachments.clear();
                                      if (item.conversation.peer.id
                                              .toString() ==
                                          update[1].toString()) {
                                        item.isWrite = true;
                                        conversations.response.items[i] = item;
                                        break;
                                      }
                                    }
                                    break;
                                }
                              }
                            }
                            return ConversationContent();
                            break;
                          case ConnectionState.done:
                            return Expanded(child: Text("STREAM BUILDER"));
                            break;
                        }
                      },
                    );
                }
              },
              future: GetConverstations(),
            )));
  }
}

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const AppBarWidget({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "CONVERSATIONS",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                letterSpacing: 1,
                fontSize: 16,
              ),
            ),
          )),
          Container(
              height: 32,
              width: 32,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: designLightGray),
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.add,
                  color: designBlack,
                ),
                onPressed: () {
                  print("Hello");
                },
              ))
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
