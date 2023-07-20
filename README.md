# animation_loading_button

![Message](https://img.shields.io/badge/just%20the%20message-8A2BE2)
[![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg)](https://github.com/Solido/awesome-flutter)
![GitHub downloads](https://img.shields.io/github/downloads/letienkhang/progessloadingbutton/total.svg)
![GitHub issues](https://img.shields.io/github/issues/letienkhang/progessloadingbutton.svg)
![GitHub watchers](https://img.shields.io/github/watchers/letienkhang/progessloadingbutton.svg)

**animation_loading_button** is a Flutter package with a simple implementation of an animated loading button, complete with success animations.

![Gif demo](https://github.com/letienkhang/progessloadingbutton/assets/44312440/8d5cec20-0331-4770-a242-e139d3444692)

## Getting Started
Follow these steps to use this package

### Add dependency

```yaml
dependencies:
  animation_loading_button: ^0.0.3
```

### Add import package

```dart
import 'package:animation_loading_button/animation_loading_button.dart';
```
### Easy to use
Simple example of use loading button<br>
Put this code in your project at an screen and learn how it works 😊
```dart
LoadingButton(
              type: LoadingButtonType.color,
              // Content inside the button when the button state is idle.
              idleStateWidget: const Text(
                'Color button',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              useEqualLoadingStateWidgetDimension: true,
              // Whether or not to animate the width of the button. Default is `true`.
              // If this is set to `false`, you might want to set the `useEqualLoadingStateWidgetDimension` parameter to `true`.
              useAnimation: true,
              loadingType: LoadingType.circleSpinIndicator,
              // If you want a fullwidth size, set this to double.infinity
              width: 150.0,
              height: 40.0,
              buttonColor: Colors.blueAccent,
              loadingColor: Colors.white,
              onPressed: (){},
            ),
```

## Source
Source code and example of this library can be found in git:
```
$ git clone https://github.com/letienkhang/progessloadingbutton.git
```

