import 'package:flutter/material.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/dialogs/dialog_common_wedgets.dart';
import 'package:moflu/supports/widgets/toast.dart';
import 'package:rego/base_core/routes/navigators.dart';

Future<bool?> showCustomInputBasicDialog({
  BuildContext? context,
  String? content = '',
  String? title,
  String cancelContent = '取消',
  Color cancelTextColor = Colors.black,
  Color cancelBgColor = Colors.white,
  String confirmContent = '确认',
  Color confirmTextColor = Colors.white,
  Color confirmBgColor = Colors.blue,
  Function? confirmCallback,
  Function? cancelCallback,
  bool outsideDismiss = false,
  bool isShowCancelBtn = true,
  bool isNeedMaxHeight = false,
  bool autoHiddenDialog = true,
  TextAlign contentTextAlign = TextAlign.center,
  List<TextSpan>? children,
  double contentRowSpacing = 1.5,
  String hintText = '',
  String? initInputText,
  int maxLength = -1,
}) async {
  context ??= navigatorContext;

  return showDialog<bool>(
    context: context!,
    builder: (context) {
      return CBInputDialogWidget(
        content: content!,
        title: title,
        cancelContent: cancelContent,
        cancelTextColor: cancelTextColor,
        cancelBgColor: cancelBgColor,
        confirmContent: confirmContent,
        confirmTextColor: confirmTextColor,
        confirmBgColor: confirmBgColor,
        isShowCancelBtn: isShowCancelBtn,
        outsideDismiss: outsideDismiss,
        confirmCallback: confirmCallback,
        cancelCallback: cancelCallback,
        isNeedMaxHeight: isNeedMaxHeight,
        autoHiddenDialog: autoHiddenDialog,
        contentTextAlign: contentTextAlign,
        contentRowSpacing: contentRowSpacing,
        hintText: hintText,
        initInputText: initInputText,
        maxLength: maxLength,
        children: children,
      );
    },
  );
}

class CBInputDialogWidget extends CBCommonDialogWidget {
  final String? inputFormat;
  final String hintText;
  final String? initInputText;
  final int maxLength;

  const CBInputDialogWidget({
    Key? key,
    BuildContext? context,
    String? content,
    String? title,
    String cancelContent = '取消',
    Color cancelTextColor = Colors.black,
    Color cancelBgColor = Colors.transparent,
    String confirmContent = '确定',
    Color confirmTextColor = Colors.white,
    Color confirmBgColor = Colors.purple,
    Function? confirmCallback,
    Function? cancelCallback,
    bool outsideDismiss = false,
    bool isShowCancelBtn = true,
    bool isShowConfirmBtn = true,
    bool isShowCloseBtn = false,
    bool isNeedMaxHeight = false,
    bool autoHiddenDialog = true,
    TextAlign contentTextAlign = TextAlign.center,
    List<TextSpan>? children,
    double contentRowSpacing = 1.5,
    this.inputFormat,
    this.hintText = '',
    this.initInputText,
    this.maxLength = -1,
  }) : super(
          key: key,
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
          isNeedMaxHeight: isNeedMaxHeight,
          autoHiddenDialog: autoHiddenDialog,
          contentTextAlign: contentTextAlign,
          rowSpacing: contentRowSpacing,
          children: children,
        );

  @override
  State<StatefulWidget> createState() {
    return CBInputDialogState();
  }
}

class CBInputDialogState extends CBCommonDialogState<CBInputDialogWidget> {
  late TextEditingController _editingController;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
    _editingController.text = widget.initInputText ?? '';
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  void confirmDialog() {
    if (_editingController.text.isEmpty) {
      if (widget.hintText.isNotEmpty) {
        cbToast(msg: widget.hintText);
      }
      return;
    }
    if (widget.autoHiddenDialog) {
      Navigator.of(context).pop(true);
    }
    if (null != widget.confirmCallback) {
      widget.confirmCallback!(_editingController.text);
    }
  }

  @override
  void cancelDialog() {
    super.cancelDialog();
    focusNode.unfocus();
  }

  @override
  Widget buildDialogContent(Widget child) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.8;
    return dialogInputContentContainer(
      child: child,
      width: width,
      onBack: () {
        focusNode.unfocus();
        if (widget.outsideDismiss) cancelDialog();
      },
    );
  }

  @override
  Widget buildContent(double minHeight, double maxHeight) {
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

  @override
  Widget buildRichContent() {
    return TextField(
      controller: _editingController,
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        //这里是关键
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFD1D1D1),
          fontSize: 14,
        ),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        counterText: '',
      ),
      maxLines: 6,
      maxLength: widget.maxLength,
    );
  }
}

Widget dialogInputContentContainer({
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
          margin: EdgeInsets.only(top: 100.dp),
          alignment: Alignment.topCenter,
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
