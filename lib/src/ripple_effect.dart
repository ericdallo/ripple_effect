import 'package:flutter/widgets.dart';
import 'package:rect_getter/rect_getter.dart';

import 'ripple_data.dart';

class Ripple extends StatefulWidget {
  Ripple({
    @required GlobalKey<RippleState> key,
    @required this.child,
    this.animationDuration = const Duration(milliseconds: 300),
    this.delay = const Duration(milliseconds: 300),
    this.shape = BoxShape.circle,
    this.inflateMultiplier = 1.3,
  }) : super(key: key);

  final Widget child;
  final Duration animationDuration;
  final Duration delay;
  final BoxShape shape;
  final double inflateMultiplier;

  @override
  RippleState createState() => RippleState();

  static GlobalKey<RippleState> createGlobalKey() {
    return new GlobalKey<RippleState>();
  }
}

class RippleState extends State<Ripple> {
  final Map<GlobalKey, RippleData> ripples = {};

  @override
  Widget build(BuildContext context) => Stack(
        children: [
              widget.child,
            ] +
            ripples.entries.map((entry) => entry.value.toWidget()).toList(),
      );

  Future<void> addRipple(GlobalKey key, Color color) async =>
      this.ripples[key] = RippleData(this, null, color);

  Future<void> startAnimation(GlobalKey key, VoidCallback callback) async {
    setState(() {
      ripples[key].rect = RectGetter.getRectFromKey(key);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        ripples[key].rect = ripples[key].rect?.inflate(
            widget.inflateMultiplier * MediaQuery.of(context).size.longestSide);
      });
      Future.delayed(widget.animationDuration + widget.delay, callback)
          .then((_) => setState(() => ripples[key]?.rect = null));
    });
  }
}

class RippleEffect extends StatefulWidget {
  RippleEffect({
    @required this.key,
    @required this.rippleKey,
    @required this.child,
    @required this.color,
  }) : super(key: key);

  final GlobalKey<_RippleEffectState> key;
  final GlobalKey<RippleState> rippleKey;
  final Widget child;
  final Color color;

  @override
  _RippleEffectState createState() => _RippleEffectState();

  static GlobalKey<_RippleEffectState> createGlobalKey() {
    return new GlobalKey<_RippleEffectState>();
  }

  static Future<void> wrap(
    GlobalKey<_RippleEffectState> rippleEffectKey,
    VoidCallback callback,
  ) {
    final rippleEffectState = rippleEffectKey?.currentState;

    final rippleState = rippleEffectState.widget?.rippleKey?.currentState;

    return rippleState?.startAnimation(
        rippleEffectState?.rectGetterKey, callback);
  }
}

class _RippleEffectState extends State<RippleEffect> {
  final rectGetterKey = RectGetter.createGlobalKey();

  @override
  void initState() {
    widget.rippleKey.currentState.addRipple(rectGetterKey, widget.color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => RectGetter(
        key: rectGetterKey,
        child: widget.child,
      );
}
