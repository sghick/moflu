import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moflu/pages/home/home_page.dart';
import 'package:moflu/pages/module/module_page.dart';
import 'package:moflu/pages/my/my_page.dart';
import 'package:moflu/pages/statistics/statistics_page.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/buttons.dart';
import 'package:moflu/supports/widgets/tab_page.dart';

class TabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    return CBTabPage(
      bottomTabs: _bottomTabs,
      pages: _tabPages,
    );
  }
}

final List<Widget> _tabPages = [
  HomePage(),
  StatisticsPage(),
  ModulePage(),
  MyPage(),
];

final List<BottomNavigationBarItem> _bottomTabs = [
  bottomBarItem(
    icon: 'icon_bottom_markt_normal'.webP,
    selIcon: 'icon_bottom_markt'.webP,
    title: '首页',
  ),
  bottomBarItem(
    icon: 'icon_bottom_shop_normal'.webP,
    selIcon: 'icon_bottom_shop'.webP,
    title: '统计',
  ),
  bottomBarItem(
    icon: 'icon_bottom_order_normal'.webP,
    selIcon: 'icon_bottom_order'.webP,
    title: '模板',
  ),
  bottomBarItem(
    icon: 'icon_bottom_management_normal'.webP,
    selIcon: 'icon_bottom_management'.webP,
    title: '我的',
  ),
];
