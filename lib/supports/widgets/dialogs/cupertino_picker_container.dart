import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPickerContainer extends StatelessWidget {
  final CupertinoPicker picker;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final FixedExtentScrollController? controller;
  final double height;
  final double toolBarHeight;
  final Color? toolBarColor;
  final Color? containerColor;

  const CupertinoPickerContainer({
    Key? key,
    required this.picker,
    this.onCancel,
    this.onConfirm,
    this.controller,
    this.height = 300.0,
    this.toolBarHeight = 40.0,
    this.toolBarColor = Colors.white,
    this.containerColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: containerColor,
      child: Column(
        children: <Widget>[
          Container(
            height: toolBarHeight,
            color: toolBarColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: onCancel ??
                      () {
                        Navigator.pop(context);
                      },
                  child: Text("取消"),
                ),
                TextButton(
                  onPressed: onConfirm ??
                      () {
                        Navigator.pop(context, controller?.selectedItem);
                      },
                  child: Text("确认"),
                ),
              ],
            ),
          ),
          Expanded(
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.dp,
              ),
              child: Container(
                height: height,
                child: picker,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
