import 'package:flutter/material.dart';

import 'ripple_effect.dart';

class RippleData {
  RippleData(this.rippleState, this.rect, this.color);

  RippleState rippleState;
  Rect rect;
  Color color;

  Widget toWidget() {
    if (rect == null) {
      return Container();
    }

    return AnimatedPositioned(
      left: rect.left,
      top: rect.top,
      right: MediaQuery.of(rippleState.context).size.width - rect.right,
      bottom: MediaQuery.of(rippleState.context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: rippleState.widget.shape,
          color: color,
        ),
      ),
      duration: rippleState.widget.animationDuration,
    );
  }
}
