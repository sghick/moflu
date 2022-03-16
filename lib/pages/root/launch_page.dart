import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moflu/pages/root/launch_animation.dart';

class LaunchPage extends StatefulWidget {
  final VoidCallback? endAnimated;

  const LaunchPage({Key? key, this.endAnimated}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: LaunchAnimation(
          padding: EdgeInsets.all(10),
          endAnimated: widget.endAnimated,
        ),
      ),
    );
  }
}
