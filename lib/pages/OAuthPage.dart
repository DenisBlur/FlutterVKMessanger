import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vk_app/supports/colors.dart';
import 'package:flutter_vk_app/supports/variables.dart';
import 'package:flutter_web_view/flutter_web_view.dart';

import 'ConversationsPage.dart';

class OAuthPage extends StatefulWidget {
  @override
  _OAuthPageState createState() => _OAuthPageState();
}

class _OAuthPageState extends State<OAuthPage>
    with SingleTickerProviderStateMixin {
  bool useLocalToken = true;
  FlutterWebView flutterWebView = new FlutterWebView();
  AnimationController _controller;
  double _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(top: 144),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SvgPicture.asset("assets/Icon.svg"),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "TxtWorldChat",
                      style: TextStyle(
                          color: designBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 36),
                    ),
                    Text(
                      "based on VK",
                      style: TextStyle(color: designGray, fontSize: 14),
                    ),
                  ],
                )),

            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  if (!useLocalToken) {
                    flutterWebView.launch(MAIN_VK_OAUTH_URL);
                    flutterWebView.onWebViewDidLoad.listen((url) {
                      print(url);
                      if (url.contains("access_token")) {
                        List<String> ResponseMain = url.split(RegExp("[=, &]"));
                        print(ResponseMain[1]);
                        flutterWebView.dismiss();
                      } else {
                        print("NO");
                      }
                    });
                  } else {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ConversationsPage();
                      },
                    ));
                  }
                },
                onTapCancel: () {
                  _controller.reverse();
                },
                onTapDown: (details) {
                  _controller.forward();
                },
                onTapUp: (details) {
                  _controller.reverse();
                },
                child: Transform.scale(
                  scale: _scale,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 100),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            CupertinoSwitch(
              value: useLocalToken,
              onChanged: (bool value) {
                setState(() {
                  useLocalToken = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
