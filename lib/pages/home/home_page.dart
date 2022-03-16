import 'package:rego/base_core/utils/string_utils.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';
import 'package:moflu/model/sqlite/data_base.dart';
import 'package:flutter/material.dart';
import 'package:moflu/supports/widgets/scaffod.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CBDoc>? _list;

  @override
  void initState() {
    super.initState();
    _queryItems();
  }

  void _queryItems() {
    dbHelper.selectDocs().then((value) {
      _list = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CBScaffold(
      title: '魔法路',
      onBackPress: () {
        return Future.value(false);
      },
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add),
        )
      ],
      child: (context) {
        return ((_list != null) && _list!.isNotEmpty)
            ? ListView.builder(
                itemCount: _list!.length,
                itemBuilder: _buildItem,
              )
            : Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text('暂无文件')],
                  ),
                ),
              );
      },
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    CBDoc doc = _list![index];
    return Container(
      child: SimpleText('${doc.name}'),
    );
  }
}
