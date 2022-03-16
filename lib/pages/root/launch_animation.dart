import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moflu/supports/widgets/space.dart';

class LaunchAnimation extends StatefulWidget {
  final EdgeInsets? padding;
  final VoidCallback? endAnimated;

  LaunchAnimation({
    this.padding = EdgeInsets.zero,
    this.endAnimated,
  });

  @override
  State<StatefulWidget> createState() => _LaunchAnimationState();
}

class _LaunchAnimationState extends State<LaunchAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addListener(() {
      setState(() {});
    });

    _controller.forward().whenComplete(() {
      if (widget.endAnimated != null) {
        widget.endAnimated!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.translate(
                offset: Offset(200.0 * (1 - _curve.value), 0.0),
                child: _aniItem('魔'),
              ),
              CBSpace.h(20),
              Transform.rotate(
                angle: (1 - _curve.value) * pi,
                child: _aniItem('法'),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.rotate(
                angle: (1 - _curve.value) * pi,
                child: _aniItem('之'),
              ),
              CBSpace.h(20),
              Transform.translate(
                offset: Offset(200.0 * (_curve.value - 1), 0.0),
                child: _aniItem('路'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aniItem(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
