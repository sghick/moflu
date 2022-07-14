import 'package:flutter/services.dart';
import 'package:moflu/supports/widgets/space.dart';
import 'package:rego/base_core/routes/navigators.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/divider.dart';
import 'package:moflu/supports/widgets/text.dart';
import 'package:flutter/material.dart';

enum PageStatus {
  /// 数据加载成功，正常页面
  DATA,

  /// 数据加载失败，缺省页面
  EMPTY,

  /// 首次进入，数据加载之前
  INIT,
}

class CBTitleBar extends StatelessWidget {
  final Widget? title;
  final List<Widget>? leading;
  final List<Widget>? actions;
  final EdgeInsets? padding;
  final double iconMargin;

  const CBTitleBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.padding,
    this.iconMargin = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: padding?.top ?? 0, bottom: padding?.bottom ?? 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _buildWidget(true)),
          title!,
          Expanded(child: _buildWidget(false)),
        ],
      ),
    );
  }

  Widget _buildWidget(bool isLeading) {
    List<Widget> originalWidgets = (isLeading ? leading : actions) ?? [];
    List<Widget> wList = [];
    for (var widget in originalWidgets) {
      if (isLeading && (wList.length > 0)) {
        wList.add(Container(
          width: iconMargin,
        ));
      }
      wList.add(widget);
      if (!isLeading && (wList.length < originalWidgets.length)) {
        wList.add((Container(
          width: iconMargin,
        )));
      }
    }
    isLeading ? wList.insert(0, SizedBox(width: padding?.left)) : null;
    isLeading ? null : wList.add(SizedBox(width: padding?.right));
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          isLeading ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: wList,
    );
  }
}

class CBBackButton extends StatelessWidget {
  final Color? color;
  final GestureTapCallback? onBack;

  const CBBackButton({Key? key, this.color, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.fromLTRB(20.dp, 10.dp, 10.dp, 10.dp),
        child: ImageIcon(
          AssetImage('icon_black_back'.webP),
          color: color,
          size: 24.dp,
        ),
      ),
      onTap: onBack != null
          ? onBack
          : () {
              goBack();
            },
    );
  }
}

class CBDiscolorContainer extends StatefulWidget {
  final Widget? child;
  final Decoration? normalDecoration;
  final Decoration? pressedDecoration;
  final onClick;
  final EdgeInsets? padding;

  const CBDiscolorContainer(
      {Key? key,
      this.normalDecoration,
      this.pressedDecoration,
      this.onClick,
      this.padding,
      this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CBDiscolorContainerState();
  }
}

class CBDiscolorContainerState extends State<CBDiscolorContainer> {
  bool? isPressing;

  @override
  void initState() {
    super.initState();
    isPressing = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (event) {
        updatePressing(true);
      },
      onTapUp: (event) {
        updatePressing(false);
      },
      onTapCancel: () {
        updatePressing(false);
      },
      onTap: widget.onClick,
      child: Container(
        padding: widget.padding,
        child: widget.child,
        decoration:
            isPressing! ? widget.pressedDecoration : widget.normalDecoration,
      ),
    );
  }

  void updatePressing(pressing) {
    if (pressing == isPressing) {
      return;
    }
    setState(() {
      isPressing = pressing;
    });
  }
}

class CBScaffold extends StatelessWidget {
  final String? title;
  final List<Widget> leading;
  final List<Widget> actions;
  final EdgeInsets? barPadding;
  final double? iconMargin;
  final Widget? titleWidget;
  final Color? appBarColor;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final WidgetBuilder child;
  final Color bkgColor;
  final bool autoAdjustKeyboard;
  final EdgeInsets pagePadding;
  final bool contentDivider;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget? defaultChild;
  final PageStatus pageStatus;
  final WillPopCallback? onBackPress;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final SystemUiOverlayStyle? systemOverlayStyle;

  const CBScaffold({
    Key? key,
    this.title,
    this.leading = const [CBBackButton()],
    this.actions = const [],
    this.barPadding,
    this.iconMargin,
    this.titleWidget,
    this.appBarColor,
    this.appBar,
    required this.child,
    this.bkgColor = Colors.white,
    this.autoAdjustKeyboard = false,
    this.pagePadding = EdgeInsets.zero,
    this.contentDivider = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
    this.defaultChild,
    this.pageStatus = PageStatus.DATA,
    this.onBackPress,
    this.scaffoldKey,
    this.bottomNavigationBar,
    this.systemOverlayStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: bkgColor,
        resizeToAvoidBottomInset: autoAdjustKeyboard,
        floatingActionButtonLocation: floatingActionButtonLocation,
        appBar: appBar ?? _appBar(),
        bottomNavigationBar: bottomNavigationBar ?? null,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _contentDivider(),
                Expanded(
                  child: Container(
                    padding: pagePadding,
                    child: _content(context),
                  ),
                ),
              ],
            )),
        floatingActionButton: floatingActionButton,
      ),
      onWillPop: onBackPress,
    );
  }

  PreferredSizeWidget? _appBar() {
    if ((title == null) && (titleWidget == null)) return null;
    return AppBar(
      backgroundColor: appBarColor ?? Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: CBTitleBar(
        padding: barPadding ?? EdgeInsets.only(right: 20.dp),
        iconMargin: iconMargin ?? 10.dp,
        title: titleWidget ?? titleBarTitleText(title),
        leading: leading,
        actions: actions,
      ),
      systemOverlayStyle: this.systemOverlayStyle ??
          SystemUiOverlayStyle(statusBarColor: Colors.white),
    );
  }

  Widget _contentDivider() {
    if (title == null || !contentDivider)
      return SizedBox(
        height: 0,
      );
    return CBDivider.h();
  }

  Widget _content(BuildContext context) {
    switch (pageStatus) {
      case PageStatus.INIT:
        return SizedBox();
      case PageStatus.EMPTY:
        return defaultChild ?? Container();
      case PageStatus.DATA:
        return _dataContent(context);
    }
    return SizedBox();
  }

  Widget _dataContent(BuildContext context) {
    if (!autoAdjustKeyboard) return child(context);
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: child(context),
    );
  }
}
