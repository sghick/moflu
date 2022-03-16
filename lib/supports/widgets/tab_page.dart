import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef InitialedContext = void Function(BuildContext context);

class CBTabPage extends StatefulWidget {
  final InitialedContext? initialized;
  final List<BottomNavigationBarItem>? bottomTabs;
  final List<Widget>? pages;
  final int initialIndex;

  const CBTabPage(
      {Key? key,
      this.initialized,
      this.bottomTabs,
      this.pages,
      this.initialIndex = 0});

  @override
  State<StatefulWidget> createState() => CBTabPageState();
}

class CBTabPageState extends State<CBTabPage> {
  int? _currentIndex;
  Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _currentPage = widget.pages![_currentIndex!];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialized != null) {
      widget.initialized!(context);
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex!,
        items: widget.bottomTabs!,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _currentPage = widget.pages![_currentIndex!];
          });
        },
        fixedColor: Colors.green,
      ),
      body: _currentPage,
    );
  }
}
