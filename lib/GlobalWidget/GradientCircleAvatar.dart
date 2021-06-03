import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vk_app/supports/colors.dart';
import 'package:flutter_vk_app/supports/global_method.dart';

class GradientCircleAvatar extends StatelessWidget {
  final List<String> stringData;
  final String separator;
  final double radius;

  const GradientCircleAvatar({this.stringData, this.separator, this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(77, 155, 144, 1),
              Color.fromRGBO(12, 101, 89, 1),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: designLightGray, width: 1)),
        child: Center(
          child: Text(
            getInitials(stringData, separator),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ));
  }
}
