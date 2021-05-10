import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';

class ImageScannerAnimation extends AnimatedWidget {
  final bool stopped;

  ImageScannerAnimation(this.stopped, {Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Animation<double> animation = listenable;
    final scorePosition = (animation.value * size.height / 2.5);

    Color color1 = ColorConstants.ISPARK_BLACK;
    Color color2 = Colors.black12;

    if (animation.status == AnimationStatus.reverse) {
      color1 = Colors.black12;
      color2 = ColorConstants.ISPARK_BLACK;
    }

    return new Positioned(
        bottom: scorePosition,
        right: 16,
        left: 16,
        child: new Opacity(
            opacity: (stopped) ? 0.0 : 1.0,
            child: Container(
              height: 45.0,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.9],
                colors: [color1, color2],
              )),
            )));
  }
}
