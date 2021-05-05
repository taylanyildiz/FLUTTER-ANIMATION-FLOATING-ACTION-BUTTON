import 'package:flutter/material.dart';
import 'widget.dart';

/// Widget Aciton class.
class ActionIcon {
  ActionIcon({
    required this.icon,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
  });

  /// Button child icon.
  final IconData icon;

  /// Button click function.
  final Function onPressed;

  /// Action button backgroundColor.
  final Color? foregroundColor;

  /// Action button icon color.
  final Color? backgroundColor;
}

class _FloatingScope extends InheritedWidget {
  const _FloatingScope({
    Key? key,
    required this.state,
    required Widget child,
  }) : super(key: key, child: child);

  final _CfloatingButtonState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      (oldWidget as _FloatingScope).state != state;
}

class CfloatingButton extends StatefulWidget {
  const CfloatingButton({
    Key? key,
    required Widget child,
    required Function onPressed,
    required List<ActionIcon> actions,
    Color? backgroundColor,
    Color? foregroundColor,
  }) : this.builder(
          key: key,
          child: child,
          onPressed: onPressed,
          actions: actions,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        );

  const CfloatingButton.builder({
    Key? key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    required this.actions,
  })   : assert(actions.length > 0),
        super(key: key);

  /// Color background.
  final Color? backgroundColor;

  /// Color foreground.
  final Color? foregroundColor;

  /// Widget child on button.
  ///
  /// cannot be null.
  final Widget child;

  /// OnClick button function.
  ///
  /// call back.
  final Function onPressed;

  /// [FloatingActionButtonAnim] child list. [ActionIcon] child.
  ///
  /// if mode is .... actions.length must be 3.
  final List<ActionIcon> actions;

  static _CfloatingButtonState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_FloatingScope>()!.state;

  @override
  _CfloatingButtonState createState() => _CfloatingButtonState();
}

class _CfloatingButtonState extends State<CfloatingButton>
    with TickerProviderStateMixin {
  /// Conroller animation.
  AnimationController? _controller;

  /// animation position and rotation.
  Animation? _rotationAnimation;

  /// Animation action button.
  Animation? actionAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 360.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeOut,
      ),
    );

    actionAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 10),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 10),
    ]).animate(_controller!);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  void closeActions() {
    _controller!.reverse();
  }

  void _handle(BuildContext context) {
    widget.onPressed.call();
    if (_controller!.status == AnimationStatus.completed)
      _controller!.reverse();
    else
      _controller!.forward();
  }

  /// set check Position
  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  Widget _buildAction(BuildContext context) {
    Widget childs = Icon(Icons.perm_camera_mic);
    bool widgetIcon = false;
    if (widget.child is Icon) {
      final a = (widget.child as Icon).color;
      final b = (widget.child as Icon).icon;
      childs = Icon(b, color: a);
      widgetIcon = true;
    } else
      widgetIcon = false;

    return Positioned(
      bottom: 30.0,
      right: 30.0,
      child: Container(
        width: 120,
        height: 120,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            FloatingActionButtonAnim(
              position: PositionAction(180, 0),
              animation: actionAnimation!,
              onClick: () => widget.actions[0].onPressed.call(),
              foregroundColor: widget.actions[0].foregroundColor,
              backgroundColor: widget.actions[0].backgroundColor,
              icon: widget.actions[0].icon,
            ),
            FloatingActionButtonAnim(
              position: PositionAction(225, 0),
              animation: actionAnimation!,
              onClick: () => widget.actions[1].onPressed.call(),
              foregroundColor: widget.actions[1].foregroundColor,
              backgroundColor: widget.actions[1].backgroundColor,
              icon: widget.actions[1].icon,
            ),
            FloatingActionButtonAnim(
              position: PositionAction(270, 0),
              animation: actionAnimation!,
              onClick: () => widget.actions[2].onPressed.call(),
              foregroundColor: widget.actions[2].foregroundColor,
              backgroundColor: widget.actions[2].backgroundColor,
              icon: widget.actions[2].icon,
            ),
            AnimatedBuilder(
              animation: _controller!,
              builder: (context, child) => Transform(
                transform: Matrix4.rotationZ(
                    getRadiansFromDegree(_rotationAnimation!.value)),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => _handle(context),
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: widgetIcon ? childs : widget.child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _FloatingScope(
      state: this,
      child: _buildAction(context),
    );
  }
}
