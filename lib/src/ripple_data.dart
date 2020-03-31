import 'package:flutter/material.dart';

class RippleData {
  RippleData({
    @required this.context,
    @required this.color,
    @required this.animationDuration,
    @required this.delay,
    @required this.shape,
    @required this.inflateMultiplier,
  });

  final BuildContext context;
  final Color color;
  final Duration animationDuration;
  final Duration delay;
  final BoxShape shape;
  final double inflateMultiplier;

  Rect rect;

  Widget toWidget() {
    if (rect == null) {
      return Container();
    }

    return AnimatedPositioned(
      left: rect.left,
      top: rect.top,
      right: MediaQuery.of(context).size.width - rect.right,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: shape,
          color: color,
        ),
      ),
      duration: animationDuration,
    );
  }
}
