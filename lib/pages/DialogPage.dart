import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_vk_app/GlobalWidget/FadeCircleAvatar.dart';
import 'package:flutter_vk_app/Widgets/DialogPage/MessageItem.dart';
import 'package:flutter_vk_app/supports/colors.dart';

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
    final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
    return SafeArea(
      child: Scaffold(
          appBar: AppBarDialogWidget(),
          body: Column(
            children: [
              Expanded(
                  child: LiveList(
                delay: Duration(milliseconds: 0),
                showItemInterval: Duration(milliseconds: 20),
                showItemDuration: Duration(milliseconds: 150),
                itemBuilder: (context, index, animation) {
                  return buildAnimatedItem(context, index, animation);
                },
                itemCount: messages.length,
              ))
              // Expanded(child: ListView.builder(
              //   itemBuilder: (context, index) {
              //     return MessageItem(
              //       avatar:
              //       "https://sun1.ufanet.userapi.com/s/v1/ig2/ZpcZQ__zK_1NYhLd9JgWHOkPD4kzigQ8E3LWjvTotiguKHKhYD1yHt0XOhcILJiehk3UFdWoHTn7ei2qtO-qvPif.jpg?size=50x0&quality=96&crop=178,169,1751,1751&ava=1",
              //       message: messages[index].text,
              //       time: "13.17",
              //       lastMessage: index+1 < messages.length ? messages[index].id != messages[index+1].id : true,
              //       isMe: messages[index].id == 0 ,
              //     );
              //   }, itemCount: messages.length,
              // ))
            ],
          )),
    );
  }

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      FadeTransition(
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
          child: MessageItem(
            avatar:
                "https://sun1.ufanet.userapi.com/s/v1/ig2/ZpcZQ__zK_1NYhLd9JgWHOkPD4kzigQ8E3LWjvTotiguKHKhYD1yHt0XOhcILJiehk3UFdWoHTn7ei2qtO-qvPif.jpg?size=50x0&quality=96&crop=178,169,1751,1751&ava=1",
            message: messages[index].text,
            time: "13.17",
            lastMessage: index + 1 < messages.length
                ? messages[index].id != messages[index + 1].id
                : true,
            isMe: messages[index].id == 0,
          ),
        ),
      );
}

class AppBarDialogWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarDialogWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
            onTap: () {
              print("Hello");
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: designLightGray))),
              height: 56,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    FadeCircleAvatar(
                      radius: 12,
                      imageUrl:
                          "https://sun2.ufanet.userapi.com/s/v1/ig2/r3LcPH35gqziLWivuq0DSsQqsqecyl623PocPxkEp9ccxHUh2c6DFR4QVPkWghnTaVAWL9ep_0x7ZMwaIaZQJhNF.jpg?size=50x0&quality=96&crop=66,95,1345,1345&ava=1",
                    ),
                    Expanded(
                      child: Text(
                        "Влад Вавилин",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            border: Border.all(color: designLightGray),
                            borderRadius: BorderRadius.circular(20)),
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.add,
                            size: 14,
                            color: designBlack,
                          ),
                          onPressed: () {
                            print("Hello");
                          },
                        ))
                  ],
                ),
              ),
            )));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}
