library loadingbutton;


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({
    Key? key,
    required this.idleStateWidget,
    this.type = LoadingButtonType.color,
    this.loadingType = LoadingType.cupertinoActivityIndicator,
    this.useAnimation = true,
    this.useEqualLoadingStateWidgetDimension = true,
    this.width = double.infinity,
    this.height = 40.0,
    this.contentGap = 6.0,
    this.borderRadius = 4.0,
    this.elevation = 2.0,
    this.buttonColor = Colors.blueAccent,
    this.loadingColor = Colors.amber,
    this.onPressed,
  }) : super(key: key);

  final LoadingButtonType type;
  final LoadingType loadingType;
  final Widget idleStateWidget;
  final bool useAnimation;
  final bool useEqualLoadingStateWidgetDimension;
  final double width;
  final double height;
  final double contentGap;
  final double borderRadius;
  final double elevation;
  final Color buttonColor;
  final Color loadingColor;
  final Function? onPressed;

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton>
    with TickerProviderStateMixin {
  final GlobalKey _globalKey = GlobalKey();

  Animation? _anim;
  AnimationController? _animController;
  final Duration _duration = const Duration(
    milliseconds: 250,
  );
  LoadingButtonState _state = LoadingButtonState.idle;
  late double _width;
  late double _height;
  late double _borderRadius;

  @override
  dispose() {
    if (_animController != null) {
      _animController!.dispose();
    }

    super.dispose();
  }

  @override
  void deactivate() {
    _reset();
    super.deactivate();
  }

  @override
  void initState() {
    _reset();
    super.initState();
  }

  void _reset() {
    _state = LoadingButtonState.idle;
    _width = widget.width;
    _height = widget.height;
    _borderRadius = widget.borderRadius;
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: SizedBox(
        key: _globalKey,
        height: _height,
        width: _width,
        child: _buildChild(context),
      ),
    );
  }

  _buildChild(BuildContext context) {
    var padding = EdgeInsets.all(
      widget.contentGap,
    );
    var buttonColor = widget.buttonColor;
    var shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
    );

    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      padding: padding,
      backgroundColor: buttonColor,
      elevation: widget.elevation,
      shape: shape,
    );

    final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
      padding: padding,
      shape: shape,
      side: BorderSide(
        color: buttonColor,
      ),
    );

    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      padding: padding,
    );

    switch (widget.type) {
      case LoadingButtonType.color:
        return ElevatedButton(
          style: elevatedButtonStyle,
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
      case LoadingButtonType.transparent:
        return TextButton(
          style: outlinedButtonStyle,
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
      case LoadingButtonType.text:
        return TextButton(
          style: textButtonStyle,
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
    }
  }

  Widget _buildChildren(BuildContext context) {
    double contentGap =
        widget.type == LoadingButtonType.text ? 0.0 : widget.contentGap;
    Widget contentWidget;

    switch (_state) {
      case LoadingButtonState.idle:
        contentWidget = widget.idleStateWidget;

        break;
      case LoadingButtonState.loading:
        contentWidget = _switchLoadingType(widget.loadingType);

        if (widget.useEqualLoadingStateWidgetDimension) {
          contentWidget = SizedBox.square(
              dimension: widget.height - (contentGap * 2),
              child: _switchLoadingType(widget.loadingType));
        }

        break;

      case LoadingButtonState.done:
        contentWidget =
            widget.loadingType == LoadingType.circularProgressIndicator
                ? _circularProgressIndicator()
                : _cupertinoActivityIndicator();
        break;
    }

    return contentWidget;
  }

  void _reverse() {
    _animController!.reverse();
  }

  _circularProgressIndicator() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        widget.loadingColor,
      ),
      strokeWidth: 3.0,
    );
  }

  _cupertinoActivityIndicator() {
    return CupertinoActivityIndicator(
      color: widget.loadingColor,
    );
  }

  _sleekCircularSlider() {
    return SvgPicture.asset(
      'assets/images/loading.svg',
      semanticsLabel: 'A shark?!',
      allowDrawingOutsideViewBox: true,
      colorFilter: ColorFilter.mode(widget.loadingColor, BlendMode.srcIn),
    );
  }

  _circularRingIndicator() {
    return SvgPicture.asset(
      'assets/images/loading2.svg',
      semanticsLabel: 'A beef',
      allowDrawingOutsideViewBox: true,
      colorFilter: ColorFilter.mode(widget.loadingColor, BlendMode.srcIn),
    );
  }

  _switchLoadingType(LoadingType type) {
    Widget widget = _circularProgressIndicator();
    switch (type) {
      case LoadingType.circularProgressIndicator:
        widget = _circularProgressIndicator();
        break;
      case LoadingType.cupertinoActivityIndicator:
        widget = _circularProgressIndicator();
        break;
      case LoadingType.circleSpinIndicator:
        widget = _sleekCircularSlider();
        break;
      case LoadingType.circleRingIndicator:
        widget = _circularRingIndicator();
        break;
    }
    return widget;
  }

  void _forward(AnimationStatusListener stateListener) {
    double initialWidth = _globalKey.currentContext!.size!.width;
    double initialBorderRadius = widget.borderRadius;
    double targetWidth = _height;
    double targetBorderRadius = _height / 2;

    _animController = AnimationController(duration: _duration, vsync: this);
    _anim = Tween(begin: 0.0, end: 1.0).animate(_animController!)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - targetWidth) * _anim!.value);
          _borderRadius = initialBorderRadius -
              ((initialBorderRadius - targetBorderRadius) * _anim!.value);
        });
      })
      ..addStatusListener(stateListener);

    _animController!.forward();
  }

  void _toDefault() {
    if (mounted) {
      setState(() {
        _state = LoadingButtonState.idle;
      });
    } else {
      _state = LoadingButtonState.idle;
    }
  }

  void _toProcessing() {
    setState(() {
      _state = LoadingButtonState.loading;
    });
  }

  VoidCallback _onButtonPressed() {
    if (widget.onPressed == null) {
      return () {};
    }

    return _manageLoadingState;
  }

  Future _manageLoadingState() async {
    if (_state != LoadingButtonState.idle) {
      return;
    }
    dynamic onIdle;

    if (widget.useAnimation) {
      _toProcessing();
      _forward((status) {
        if (status == AnimationStatus.dismissed) {
          _toDefault();
          if (onIdle != null &&
              (onIdle is VoidCallback || onIdle is FormFieldValidator)) {
            onIdle();
          }
        }
      });
      onIdle = await widget.onPressed!();
      _reverse();
    } else {
      _toProcessing();
      onIdle = await widget.onPressed!();
      _toDefault();
      if (onIdle != null &&
          (onIdle is VoidCallback || onIdle is FormFieldValidator)) {
        onIdle();
      }
    }
  }
}

enum LoadingButtonState {
  idle,
  loading,
  done,
}

enum LoadingButtonType {
  color,
  transparent,
  text,
}

enum LoadingType {
  circularProgressIndicator,
  cupertinoActivityIndicator,
  circleSpinIndicator,
  circleRingIndicator
}

