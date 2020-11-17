import 'package:flutter/widgets.dart';
import 'package:rect_getter/rect_getter.dart';

import 'ripple_data.dart';

/// Wrap your screen with this widget.
///
/// The ripple effect will growth until reaches this widget.
/// It requires a [GlobalKey] that can be generated
/// via [RipplePage.createGlobalKey()].
///
/// This should be used with the [RippleEffect] widget to work.
///
/// ```dart
/// class Stateless extends StatelessWidget {
///
///   final pageKey = RipplePage.createGlobalKey();
///
///   @override
///   Widget build(BuildContext context) {
///     return RipplePage(
///       child: Scaffold(body: MyPage()),
///       pageKey: pageKey,
///     );
///   }
/// }
/// ```
class RipplePage extends StatefulWidget {
  RipplePage({
    @required GlobalKey<_RipplePageState> pageKey,
    @required this.child,
    this.animationEndDelay = const Duration(milliseconds: 500),
  }) : super(key: pageKey);

  final Widget child;
  final Duration animationEndDelay;

  @override
  _RipplePageState createState() => _RipplePageState();

  static GlobalKey<_RipplePageState> createGlobalKey() =>
      new GlobalKey<_RipplePageState>();
}

class _RipplePageState extends State<RipplePage> {
  final Map<GlobalKey, RippleData> ripples = {};

  @override
  Widget build(BuildContext context) => Stack(
        children: [
              widget.child,
            ] +
            ripples.entries.map((entry) => entry.value.toWidget()).toList(),
      );

  Future<void> addRipple(GlobalKey key, RippleData data) async =>
      this.ripples[key] = data;

  Future<void> startAnimation(GlobalKey key, VoidCallback callback) async {
    final data = ripples[key];

    setState(() {
      data.rect = RectGetter.getRectFromKey(key);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final inflateSize =
          data.inflateMultiplier * MediaQuery.of(context).size.longestSide;
      setState(() {
        data.rect = data.rect?.inflate(inflateSize);
      });
      Future.delayed(data.animationDuration + data.delay, callback).then((_) =>
          Future.delayed(widget.animationEndDelay,
              () => setState(() => data.rect = null)));
    });
  }
}

/// Responsible to wrap the origin point of the ripple effect.
///
/// Often this should wrap a button widget or the animation
/// start widget.
/// It requires to call [RippleEffect.start] to start the animation.
///
/// ```dart
/// RippleEffect(
///   pageKey: pageKey,
///   effectKey: effectKey,
///   color: Colors.blue,
///   child: FloatingActionButton(
///     child: Icon(Icons.arrow_back),
///     onPressed: () => RippleEffect.start(effectKey, toNextPage),
///   ),
/// )
/// ```
class RippleEffect extends StatefulWidget {
  RippleEffect({
    @required this.pageKey,
    @required this.effectKey,
    @required this.color,
    @required this.child,
    this.animationDuration = const Duration(milliseconds: 300),
    this.delay = const Duration(milliseconds: 300),
    this.shape = BoxShape.circle,
    this.inflateMultiplier = 1.3,
  }) : super(key: effectKey);

  final GlobalKey<_RipplePageState> pageKey;
  final GlobalKey<_RippleEffectState> effectKey;
  final Color color;
  final Widget child;
  final Duration animationDuration;
  final Duration delay;
  final BoxShape shape;
  final double inflateMultiplier;

  @override
  _RippleEffectState createState() => _RippleEffectState();

  static GlobalKey<_RippleEffectState> createGlobalKey() =>
      new GlobalKey<_RippleEffectState>();

  /// Start the animation and call [callback] after the animation.
  static Future<void> start(
    GlobalKey<_RippleEffectState> rippleEffectKey,
    VoidCallback callback,
  ) {
    final rippleEffectState = rippleEffectKey?.currentState;

    final rippleState = rippleEffectState.widget?.pageKey?.currentState;

    return rippleState?.startAnimation(
        rippleEffectState?.rectGetterKey, callback);
  }
}

class _RippleEffectState extends State<RippleEffect> {
  final rectGetterKey = RectGetter.createGlobalKey();

  @override
  void initState() {
    super.initState();
    final data = RippleData(
      context: context,
      color: widget.color,
      animationDuration: widget.animationDuration,
      delay: widget.delay,
      shape: widget.shape,
      inflateMultiplier: widget.inflateMultiplier,
    );
    widget.pageKey.currentState.addRipple(rectGetterKey, data);
  }

  @override
  Widget build(BuildContext context) => RectGetter(
        key: rectGetterKey,
        child: widget.child,
      );
}
