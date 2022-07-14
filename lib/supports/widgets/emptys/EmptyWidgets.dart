import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/utils/common_utils.dart';
import 'package:moflu/supports/widgets/space.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';

typedef OnReLoad = Function();

class EmptyWidget extends StatelessWidget {
  final String? hintIcon;
  final double? hintIconWidth;
  final double? hintIconHeight;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final bool showReloadButton;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final OnReLoad? onReload;
  final Widget? child;

  const EmptyWidget({
    Key? key,
    this.hintIcon,
    this.hintIconWidth,
    this.hintIconHeight,
    this.hintText,
    this.hintTextStyle,
    this.showReloadButton = false,
    this.buttonText = '重新加载',
    this.buttonTextStyle,
    this.onReload,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SizedBox(),
            flex: 2,
          ),
          Visibility(
            visible: !EmptyUtils.isEmptyString(hintIcon),
            child: SizedBox(
              width: this.hintIconWidth ?? 150.dp,
              height: this.hintIconHeight ?? 150.dp,
              child: Image.asset(hintIcon ?? ''),
            ),
          ),
          CBSpace.v(15.dp),
          Visibility(
            visible: !EmptyUtils.isEmptyString(hintText),
            child: SimpleText(
              hintText ?? '',
              style: this.hintTextStyle ?? newStyle.middleSize.blue,
            ),
          ),
          CBSpace.v(35.dp),
          Visibility(
            visible: showReloadButton && !EmptyUtils.isEmptyString(buttonText),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleText(
                  buttonText ?? '',
                  contentPadding: EdgeInsets.only(
                      left: 10.dp, right: 10.dp, top: 3.dp, bottom: 3.dp),
                  borderRadius: 3,
                  borderColor: buttonTextStyle?.color ?? CBColors.blue,
                  style: buttonTextStyle ?? newStyle.standardSize.blue,
                  onClick: onReload,
                ),
              ],
            ),
          ),
          child ?? Container(),
          Spacer(flex: 3)
        ],
      ),
    );
  }
}

class EmptyNoDataWidget extends EmptyWidget {
  EmptyNoDataWidget({
    Key? key,
    bool showReloadButton = false,
    String? buttonText,
    OnReLoad? onReload,
  }) : super(
          key: key,
          hintText: '暂无数据',
          showReloadButton: showReloadButton,
          buttonText: buttonText,
          onReload: onReload,
        );
}

class EmptyNoNetWidget extends EmptyWidget {
  EmptyNoNetWidget({
    Key? key,
    required OnReLoad onReload,
  }) : super(
          key: key,
          hintText: '网络请求失败，请检查您的网络',
          showReloadButton: true,
          buttonText: '重新加载',
          onReload: onReload,
        );
}
