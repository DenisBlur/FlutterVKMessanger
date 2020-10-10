import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vk_app/pages/OAuthPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Rubik',
          platform: TargetPlatform.iOS,
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: OAuthPage());
  }
}
