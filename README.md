# ripple_effect

A easy way to achieve a ripple effect on you flutter app.

<img src="https://github.com/ericdallo/ripple_effect/blob/assets/ripple_effect.gif" width="240">

## Usage

First you need to wrap your page/Scaffold with the `RipplePage` widget, the ripple efect will growth until this widget. Then 
wrap with the `RippleEffect` where the animation should begin. When the animation should begin, call the `RippleEffect.start` method passing you callback method(often navigate to other page).

The `RipplePage` and `RippleEffect` widgets need their `GlobalKey`s respectively to work.

## Example

```dart
class Stateless extends StatelessWidget {
  final pageKey = RipplePage.createGlobalKey();
  final effectKey = RippleEffect.createGlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return RipplePage(
      child: Scaffold(
        body: Center(),
        floatingActionButton: RippleEffect(
          pageKey: pageKey,
          effectKey: effectKey,
          color: Colors.blue,
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () =>
                 RippleEffect.start(effectKey, () => toNextPage(context)),
            child: Icon(Icons.arrow_back),
          ),
        )
      ),
    );
  }
}
```
