import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';

class FadeCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const FadeCircleAvatar({this.imageUrl, this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: radius*2,
        height: radius*2,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage, image: imageUrl)));
  }
}
