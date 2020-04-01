[![Pub Package](https://img.shields.io/pub/v/ripple_effect.svg?color=0175C2)](https://pub.dev/packages/ripple_effect)

# ripple_effect

A easy way to achieve a ripple effect on you flutter app.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7820865/78139282-a2e49c00-73fe-11ea-9159-7ea019c87d0e.gif" width="240">
</p>

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
