import 'package:flutter/material.dart';
import 'package:rego/base_core/routes/navigators.dart';
import 'package:rego/base_core/utils/screen_utils.dart';
import 'package:rego/base_core/utils/string_utils.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/space.dart';

Future<bool?> showCustomBasicDialog({
  BuildContext? context,
  String? content,
  String? title,
  String cancelContent = '取消',
  Color cancelTextColor = Colors.black,
  Color cancelBgColor = Colors.transparent,
  String confirmContent = '确定',
  Color confirmTextColor = Colors.white,
  Color confirmBgColor = Colors.lightBlue,
  Function? confirmCallback,
  Function? cancelCallback,
  Function? closeCallback,
  bool outsideDismiss = false,
  bool isShowCancelBtn = true,
  bool isShowConfirmBtn = true,
  bool isShowCloseBtn = true,
  bool isNeedMaxHeight = false,
  bool autoHiddenDialog = true,
  TextAlign contentTextAlign = TextAlign.center,
  List<TextSpan>? children,
  double contentRowSpacing = 1.5,
}) async {
  context ??= navigatorContext;

  return showDialog<bool>(
    context: context!,
    builder: (context) {
      return CBCommonDialogWidget(
        content: content,
        title: title,
        cancelContent: cancelContent,
        cancelTextColor: cancelTextColor,
        cancelBgColor: cancelBgColor,
        confirmContent: confirmContent,
        confirmTextColor: confirmTextColor,
        confirmBgColor: confirmBgColor,
        isShowCancelBtn: isShowCancelBtn,
        isShowConfirmBtn: isShowConfirmBtn,
        isShowCloseBtn: isShowCloseBtn,
        outsideDismiss: outsideDismiss,
        confirmCallback: confirmCallback,
        cancelCallback: cancelCallback,
        closeCallback: closeCallback,
        isNeedMaxHeight: isNeedMaxHeight,
        autoHiddenDialog: autoHiddenDialog,
        contentTextAlign: contentTextAlign,
        rowSpacing: contentRowSpacing,
        children: children,
      );
    },
  );
}

class CBCommonDialogWidget extends StatefulWidget {
  final String? title; //标题
  final String? content; //内容
  final String cancelContent; //取消按钮文本
  final Color cancelTextColor; // 取消按钮文本颜色
  final String confirmContent; //确认按钮文本
  final Color confirmTextColor; // 确认按钮文本颜色
  final Color cancelBgColor;
  final Color confirmBgColor;
  final bool outsideDismiss; //点击弹窗外部，关闭弹窗，默认为true true：可以关闭 false：不可以关闭
  final Function? confirmCallback;
  final Function? cancelCallback;
  final Function? closeCallback;
  final bool isShowCancelBtn;
  final bool isShowConfirmBtn;
  final bool isShowCloseBtn;
  final bool isNeedMaxHeight; //是否需要最大高度   todo  。。。。。
  final bool autoHiddenDialog; //点击确认或取消默认自动隐藏dialog
  final List<TextSpan>? children; //富文本
  final TextAlign contentTextAlign; //内容对齐方式
  final double rowSpacing; //内容的行间距

  const CBCommonDialogWidget({
    Key? key,
    this.title,
    this.content,
    this.cancelContent = '取消',
    this.cancelTextColor = Colors.black,
    this.confirmContent = '确定',
    this.confirmTextColor = Colors.white,
    this.cancelBgColor = Colors.transparent,
    this.confirmBgColor = Colors.lightBlue,
    this.outsideDismiss = false,
    this.cancelCallback,
    this.confirmCallback,
    this.closeCallback,
    this.isShowCancelBtn = false,
    this.isShowConfirmBtn = true,
    this.isShowCloseBtn = true,
    this.isNeedMaxHeight = false,
    this.autoHiddenDialog = true,
    this.children,
    this.contentTextAlign = TextAlign.center,
    this.rowSpacing = 1.5,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CBCommonDialogState();
  }
}

class CBCommonDialogState<DialogWidget extends CBCommonDialogWidget>
    extends State<DialogWidget> {
  void confirmDialog() {
    if (widget.autoHiddenDialog) {
      Navigator.of(context).pop(true);
    }
    if (null != widget.confirmCallback) {
      widget.confirmCallback!();
    }
  }

  void cancelDialog() {
    if (null != widget.cancelCallback) {
      widget.cancelCallback!();
    } else {
      Navigator.of(context).pop(false);
    }
  }

  void closeDialog() {
    if (null != widget.closeCallback) {
      widget.closeCallback!();
    } else {
      Navigator.of(context).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final minHeight = size.width * 0.3;
    final maxHeight = size.height * 0.4;

    Widget _container = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTitle(),
        buildContent(minHeight, maxHeight),
        buildButtons(),
      ],
    );
    _container =
        widget.isShowCloseBtn ? buildCloseContainer(_container) : _container;
    return buildDialogContent(_container);
  }

  Widget buildDialogContent(Widget child) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.8;
    return dialogContentContainer(
      child: child,
      width: width,
      onBack: () {
        if (widget.outsideDismiss) cancelDialog();
      },
    );
  }

  Widget buildCloseContainer(Widget child) {
    Color color = hasTitle ? Colors.white : Colors.black;
    return Stack(
      children: [
        child,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 56.dp,
              height: 56.dp,
              child: buildCloseBtn(color),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCloseBtn(Color color) {
    return IconButton(
      onPressed: () {
        closeDialog();
      },
      icon: Image.asset('icon_close'.png, color: color),
    );
  }

  Widget buildTitle() {
    if (!hasTitle) {
      return Container();
    }
    return Container(
      height: 56.dp,
      padding: EdgeInsets.only(left: 40.dp, right: 40.dp),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6.dp),
          topRight: Radius.circular(6.dp),
        ),
      ),
      child: Center(
        child: SimpleText(
          widget.title ?? '',
          style: newStyle.largeSize.white,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget buildContent(double minHeight, double maxHeight) {
    if (widget.content == null || widget.content!.isEmpty) {
      return Container(
        constraints: BoxConstraints(minHeight: minHeight),
      );
    }
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: minHeight),
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        margin: EdgeInsets.only(right: 20.dp, left: 20.dp, top: 20.dp),
        child: SingleChildScrollView(
          child: Container(
            alignment: bridgeAlign(widget.contentTextAlign),
            color: Colors.white,
            child: buildRichContent(),
          ),
        ),
      ),
    );
  }

  Widget buildRichContent() {
    return RichText(
      textAlign: widget.contentTextAlign,
      text: TextSpan(
        text: getText(widget.content),
        style: TextStyle(
          fontSize: TextSize.large,
          color: Colors.black,
          height: widget.rowSpacing,
        ),
        children: widget.children != null && widget.children!.isNotEmpty
            ? widget.children
            : [],
      ),
    );
  }

  Widget buildButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.isShowConfirmBtn,
              child: buildRightButton(),
            ),
          ],
        ),
        CBSpace.v(10.dp),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.isShowCancelBtn,
              child: buildLeftButton(),
            ),
          ],
        ),
        CBSpace.v(30.dp),
      ],
    );
  }

  Widget buildLeftButton() {
    return GestureDetector(
      onTap: () {
        cancelDialog();
      },
      child: Container(
        width: 180.dp,
        height: 40.dp,
        decoration: BoxDecoration(
          color: widget.cancelBgColor,
          borderRadius: BorderRadius.all(Radius.circular(8.dp)),
        ),
        alignment: Alignment.center,
        child: SimpleText(
          widget.cancelContent,
          style: newStyle.normanSize.color(widget.cancelTextColor),
        ),
      ),
    );
  }

  Widget buildRightButton() {
    return GestureDetector(
      onTap: () {
        confirmDialog();
      },
      child: Container(
        width: 180.dp,
        height: 40.dp,
        decoration: BoxDecoration(
          color: widget.confirmBgColor,
          borderRadius: BorderRadius.all(Radius.circular(8.dp)),
        ),
        alignment: Alignment.center,
        // color: widget.confirmBgColor,
        child: SimpleText(
          widget.confirmContent,
          style: newStyle.normanSize.color(widget.confirmTextColor),
        ),
      ),
    );
  }

  AlignmentGeometry bridgeAlign(TextAlign align) {
    switch (align) {
      case TextAlign.center:
        {
          return Alignment.center;
        }
      case TextAlign.start:
      case TextAlign.left:
        {
          return Alignment.centerLeft;
        }
      case TextAlign.end:
      case TextAlign.right:
        {
          return Alignment.centerRight;
        }
      default:
        {
          return Alignment.centerLeft;
        }
    }
  }

  bool get hasTitle {
    if (widget.title == null || widget.title!.isEmpty) {
      return false;
    }
    return true;
  }
}

Widget dialogContentContainer({
  required Widget child,
  GestureTapCallback? onBack,
  GestureTapCallback? onTap,
  double? width,
  Color containerColor = Colors.white,
}) {
  return Material(
    type: MaterialType.transparency,
    child: WillPopScope(
      // WillPopScope用于处理是否离开当前页面
      child: GestureDetector(
        onTap: onBack,
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: onTap ?? () {},
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(6.dp),
              ),
              child: child,
            ),
          ),
        ),
      ),
      onWillPop: () {
        return Future.value(false);
      },
    ),
  );
}
