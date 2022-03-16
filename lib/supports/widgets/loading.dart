import 'package:flutter/material.dart';
import 'package:rego/base_core/utils/screen_utils.dart';

class CBLoading extends StatefulWidget {
  final GestureTapCallback? onTap;

  const CBLoading(Key? key, {this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CBLoadingState();
}

class CBLoadingState extends State<CBLoading> {
  bool shown = false;

  show() {
    if (shown) {
      return;
    }
    setState(() {
      shown = true;
    });
  }

  dismiss() {
    if (!shown) {
      return;
    }
    setState(() {
      shown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: shown,
        child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.dp),
                    color: Color(0xa0e0e0e0),
                  ),
                  padding: EdgeInsets.all(20.dp),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                  )),
            )));
  }
}
