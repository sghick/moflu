import 'dart:async';
import 'package:rego/base_core/widgets/text_widgets.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/utils/common_utils.dart';
import 'package:moflu/supports/widgets/space.dart';
import 'package:flutter/material.dart';

Widget titleBarIconButton(image, onClick) {
  return GestureDetector(
      onTap: onClick,
      child: Container(
          child: Container(
        width: 35.dp,
        height: 35.dp,
        decoration: BoxDecoration(
          color: Color(0xa0000000),
//            color: Colors.red,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(0),
        child: Image.asset(image),
      )));
}

Widget formButton(String text, onPressed,
    {EdgeInsets? padding,
    Color? filledColor,
    Color? borderColor,
    String? prefixIcon,
    Color? textColor,
    double fixedWidth = 0}) {
  padding ??= EdgeInsets.only(left: 56.dp, right: 56.dp);
  borderColor ??= filledColor;
  if (fixedWidth > 0) {
    padding = null;
  }

  Widget prefixWidget = SizedBox();
  Widget prefixPadding = SizedBox();
  if (prefixIcon != null) {
    prefixWidget = Image.asset(prefixIcon);
    prefixPadding = CBSpace.h(10.dp);
  }

  return Container(
      padding: padding,
      alignment: Alignment.center,
      child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        color: filledColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor!,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            prefixWidget,
            prefixPadding,
            SimpleText(
              text,
              height: 50.dp,
              style: newStyle.color(textColor).size(15.dp),
              width: fixedWidth <= 0 ? null : fixedWidth,
            )
          ],
        ),
      ));
}

enum CountdownButtonStatus {
  NEW,
  COUNTING,
  FINISHED,
}

typedef bool CountDownButtonOnClick();

class CountDownButton extends StatefulWidget {
  String? initText;
  String? finishText;
  int seconds;
  String? persistentKey;
  CountDownButtonOnClick? onClick;
  bool diskPersistent = false; //TODO

  CountDownButton(
      {Key? key,
      this.initText,
      this.finishText,
      this.seconds = 10,
      this.persistentKey = '',
      this.onClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CountDownButtonState();
  }
}

class _CountDownButtonState extends State<CountDownButton> {
  Map<String, int> _startTimeRecord = {};
  var oneSecond = Duration(seconds: 1);
  CountdownButtonStatus? status;
  int? leftSeconds;
  Timer? timer;
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    var startTime = _startTimeRecord[widget.persistentKey];
    if (startTime == null) {
      status = CountdownButtonStatus.NEW;
      return;
    }
    int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (now - startTime < widget.seconds) {
      _startCounting(false);
    } else {
      status = CountdownButtonStatus.FINISHED;
    }
  }

  @override
  Widget build(BuildContext context) {
    String? text;
    switch (status) {
      case CountdownButtonStatus.NEW:
        text = "获取验证码";
        break;
      case CountdownButtonStatus.FINISHED:
        text = "点击重新获取";
        break;
      case CountdownButtonStatus.COUNTING:
        text = "${leftSeconds}s";
        break;
    }

    var bkgColor = status == CountdownButtonStatus.COUNTING
        ? CBColors.lightGray
        : CBColors.orange;

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onPressed,
        child: Focus(
          autofocus: true,
          focusNode: _focusNode,
          child: SimpleText(text,
              bkgColor: bkgColor,
              borderRadius: 4.dp,
              style: newStyle.white.smallSize.height(1)),
        ));
  }

  void _onPressed() {
    FocusScope.of(context).requestFocus(_focusNode);
    if (status == CountdownButtonStatus.COUNTING || widget.onClick == null)
      return;
    if (widget.onClick!()) {
      _startCounting(true);
    }
  }

  void _startCounting(bool isNew) {
    int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    setState(() {
      status = CountdownButtonStatus.COUNTING;
      if (isNew) {
        _startTimeRecord[widget.persistentKey!] = now;
      }
      leftSeconds = (widget.seconds -
              (now - _startTimeRecord[widget.persistentKey]!.toInt()))
          .between(0, widget.seconds);
    });
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer.periodic(oneSecond, (t) {
      setState(() {
        var timeEscape = (DateTime.now().millisecondsSinceEpoch ~/ 1000 -
            _startTimeRecord[widget.persistentKey]!.toInt());
        if (timeEscape >= widget.seconds) {
          timer!.cancel();
          timer = null;
          status = CountdownButtonStatus.FINISHED;
        } else {
          leftSeconds =
              (widget.seconds - timeEscape).between(0, widget.seconds);
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
