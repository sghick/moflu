import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CBGradientStyle {
  background,
  child,
}

class CBGradient extends StatelessWidget {
  final CBGradientStyle style;
  final List<Color> colors;
  final Widget? child;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final double radius; // only for background style

  const CBGradient.fromBackgroundStyle({
    Key? key,
    required this.colors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.child,
    this.radius = 0,
  }) : this.style = CBGradientStyle.background;

  const CBGradient.fromChildStyle({
    Key? key,
    required this.colors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.child,
    this.radius = 0,
  }) : this.style = CBGradientStyle.child;

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case CBGradientStyle.background:
        return _buildBackgroundStyle();
      case CBGradientStyle.child:
        return _buildChildStyle();
    }
  }

  Widget _buildBackgroundStyle() {
    Widget gradient = _gradientWidget();
    return (child != null)
        ? Stack(
            children: [
              gradient,
              child!,
            ],
          )
        : gradient;
  }

  Widget _buildChildStyle() {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: begin,
          end: end,
          colors: colors,
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: child,
    );
  }

  Widget _gradientWidget() {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: begin,
          end: end,
          colors: colors,
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
      ),
    );
  }
}
