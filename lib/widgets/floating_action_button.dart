import 'package:flutter/material.dart';
import 'package:flutter_animation_floating_button/widgets/cf_floating_button.dart';

class PositionAction {
  final double x;
  final double y;

  PositionAction(this.x, this.y);
}

abstract class FloatingActionTransiTransformable extends AnimatedWidget {
  /// Constructor.
  const FloatingActionTransiTransformable({
    Key? key,
    required this.animation,
    required this.onPressed,
    this.backgroundColor,
    this.position,
  }) : super(key: key, listenable: animation);

  /// Transform animation
  final Animation animation;

  /// Button Color background
  final Color? backgroundColor;

  /// Click button Function.
  final Function onPressed;

  /// Position value
  final PositionAction? position;

  void _handle(BuildContext context) {
    onPressed.call();
    CfloatingButton.of(context).closeActions();
  }

  double _position(BuildContext context, double degree) {
    return CfloatingButton.of(context).getRadiansFromDegree(degree);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset.fromDirection(
              _position(context, position!.x), animation.value * 80),
          child: Transform(
            transform: Matrix4.identity()
              ..scale(
                  animation.drive(Tween<double>(begin: 0.0, end: 1.0)).value),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () => _handle(context),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: buildAction(context),
              ),
            ),
          ),
        );
      },
    );
  }

  @protected
  Widget buildAction(BuildContext context);
}

class FloatingActionButtonAnim extends FloatingActionTransiTransformable {
  /// Constructor.
  FloatingActionButtonAnim({
    Key? key,
    required this.animation,
    this.onClick,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.position,
  }) : super(
          key: key,
          animation: animation,
          backgroundColor: backgroundColor,
          onPressed: onClick!,
          position: position,
        );

  /// Transition animaion.
  final Animation animation;

  /// Button background color.
  final Color? backgroundColor;

  /// Button icon.
  final IconData icon;

  /// Icon color.
  final Color? foregroundColor;

  /// Click button Function
  final Function()? onClick;

  /// Position value
  final PositionAction? position;

  @override
  Widget buildAction(BuildContext context) => Icon(
        icon,
        color: foregroundColor ?? Colors.white,
      );
}
