# progess_loading_button

![Message](https://img.shields.io/badge/just%20the%20message-8A2BE2)
[![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg)](https://github.com/Solido/awesome-flutter)
![GitHub downloads](https://img.shields.io/github/downloads/letienkhang/progessloadingbutton/total.svg)
![GitHub issues](https://img.shields.io/github/issues/letienkhang/progessloadingbutton.svg)
![GitHub watchers](https://img.shields.io/github/watchers/letienkhang/progessloadingbutton.svg)

**progess_loading_button** is a Flutter package with a simple implementation of an animated loading button, complete with success animations.

## Getting Started
Follow these steps to use this package

### Add dependency

```yaml
dependencies:
  progessloadingbutton: ^0.0.1
```

### Add import package

```dart
import 'package:progessloadingbutton/loadingbutton.dart';
```
### Easy to use
Simple example of use Progess loading button<br>
Put this code in your project at an screen and learn how it works 😊
```dart
LoadingButton(
              type: LoadingButtonType.color,
              // Content inside the button when the button state is idle.
              idleStateWidget: const Text(
                'Elevated button',
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
### Examples
You can check more examples of using this package [here](example/lib)

<br>
<div align="center" >
  <p>Thanks to all contributors of this package</p>
  <a href="https://github.com/Frezyx/group_button/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=Frezyx/group_button" />
  </a>
</div>
<br>

For help getting started with 😍 Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

