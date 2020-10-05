import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vk_app/Models/ConverstationModel.dart';
import 'package:flutter_vk_app/Models/LongPoll/LongPollWrapper.dart';
import 'package:flutter_vk_app/Models/Message/MessageJson.dart';
import 'package:flutter_vk_app/Widgets/ConversationContent.dart';
import 'package:flutter_vk_app/Widgets/ConversationItem.dart';
import 'package:flutter_vk_app/supports/LongPollMethods/longPollWrapper.dart';
import 'package:flutter_vk_app/supports/colors.dart';
import 'package:flutter_vk_app/supports/global_method.dart';
import 'package:flutter_vk_app/supports/variables.dart';
import 'package:http/http.dart' as http;

import 'DialogPage.dart';

class ConversationsPage extends StatefulWidget {
  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

Converstation converstations;
LongPollWrapper _longPollWrapper;

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

  Stream<List<Object>> GetLongPoll() async* {
    while (true) {
      if (_longPollWrapper == null) {
        await GetMainDataLongPoll();
      } else {
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

        var url = "http://" +
            server +
            "?act=a_check&key=" +
            key +
            "&wait=25&mode=2&ts=" +
            ts +
            "&version=3";
        var response = await http.get(url);
        Map<String, dynamic> map = jsonDecode(response.body.toString());
        LongPollAnswer answer = LongPollAnswer.fromJson(map);
        for (var object in answer.updates) {
          yield object;
        }
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
      converstations = Converstation.fromJson(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Container(
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
          ),
          Expanded(
              child: FutureBuilder(
            // ignore: missing_return
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(child: CircularProgressIndicator());
                  break;
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  break;
                case ConnectionState.active:
                  return Center(child: CircularProgressIndicator());
                  break;
                case ConnectionState.done:
                  return StreamBuilder(
                    initialData: false,
                    stream: GetLongPoll(),
                    key: UniqueKey(),
                    // ignore: missing_return
                    builder:
                        // ignore: missing_return
                        (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          break;
                        case ConnectionState.waiting:
                          print(snapshot.data);
                          longPollWrap(snapshot.data, converstations);
                          return ConversationContent(
                              converstations: converstations);
                          break;
                        case ConnectionState.active:
                          print(snapshot.data);
                          longPollWrap(snapshot.data, converstations);
                          return ConversationContent(
                              converstations: converstations);
                          break;
                        case ConnectionState.done:
                          return Text("done");
                          break;
                      }
                    },
                  );
                  break;
              }
            },
            future: GetConverstations(),
          )),
          Container(
            height: 56,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  offset: Offset(0, -1),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.1))
            ]),
          ),
        ]),
      ),
    );
  }
}
