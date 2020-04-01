/// This library allows apply a ripple effect to the app screen.
///
/// It requires to wrap the page or the area where the ripple effect
/// will happen with the [RipplePage] widget, then wrap the start point of
/// the effect with the [RippleEffect] widget, finally, to start the animation,
/// use [RippleEffect.start].
///
/// ```dart
/// class Stateless extends StatelessWidget {
///   final pageKey = RipplePage.createGlobalKey();
///   final effectKey = RippleEffect.createGlobalKey();
///
///   @override
///   Widget build(BuildContext context) {
///     return RipplePage(
///       child: Scaffold(
///         body: Center(),
///         floatingActionButton: RippleEffect(
///           pageKey: pageKey,
///           effectKey: effectKey,
///           color: Colors.blue,
///           child: FloatingActionButton(
///             backgroundColor: Colors.blue,
///             onPressed: () =>
///                  RippleEffect.start(effectKey, () => toNextPage(context)),
///             child: Icon(Icons.arrow_back),
///           ),
///         )
///       ),
///     );
///   }
/// }
///
/// ```

library ripple_effect;

export 'src/ripple_effect.dart' show RipplePage, RippleEffect;
export 'src/transition.dart';
