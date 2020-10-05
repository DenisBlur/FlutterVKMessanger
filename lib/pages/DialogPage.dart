import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  @override
  _DialogPageState createState() => _DialogPageState();
}

class Message {
  int id;
  String text;

  Message({@required this.id, @required this.text});
}

class _DialogPageState extends State<DialogPage> {
  List<Message> messages = [
    Message(id: 0, text: "Привет"),
    Message(id: 2, text: "Привет!"),
    Message(id: 2, text: "Как жизнь?"),
    Message(id: 0, text: "Все хорошо)"),
    Message(id: 0, text: "У тебя как?"),
    Message(id: 2, text: "Отсоси"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Влад Вавилин",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "Был в сети 2 минуты назад",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.2),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return messages[index].id == 0
                        ? Row(
                            children: [
                              Expanded(child: SizedBox()),
                              Container(
                                child: Text(
                                  messages[index].text,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                color: Color.fromRGBO(240, 140, 140, 1),
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(bottom: 8),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              Container(
                                child: Text(
                                  messages[index].text,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                color: Color.fromRGBO(240, 140, 140, 1),
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(bottom: 8),
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          );
                  },
                  itemCount: messages.length,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
                border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                    width: 0.5),
              ),
              padding: EdgeInsets.only(
                  left: 16, right: 16, top: 4, bottom: 4),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Write message",
                  border: InputBorder.none,
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
