import 'package:flutter/widgets.dart';

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (_context, _animation1, _animation2) => page,
          transitionsBuilder: (_context, animation1, _animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}
