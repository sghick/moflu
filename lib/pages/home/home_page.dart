import 'dart:io';

import 'package:moflu/model/json/home.dart';
import 'package:moflu/pages/home/object/option_manager.dart';
import 'package:moflu/pages/home/views/doc_view.dart';
import 'package:moflu/pages/home/views/file_view.dart';
import 'package:moflu/pages/home/views/unknow_view.dart';
import 'package:moflu/supports/widgets/dialogs/dialog_common_input_widget.dart';
import 'package:moflu/model/sqlite/data_base.dart';
import 'package:flutter/material.dart';
import 'package:moflu/supports/widgets/scaffod.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FileSystemEntity>? _list;

  @override
  void initState() {
    super.initState();
    docEventBus.on<DocEventItem>().listen((event) async {
      Directory rootDir = await optionManager.rootDir;
      if (event.dir?.path == rootDir.path) {
        _queryItems();
      }
    });
    _queryItems();
  }

  void _queryItems() {
    optionManager.rootDir.then((value) {
      _list = value.listSync().toList();
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
          onPressed: _onCreateDoc,
          icon: Icon(Icons.add_box),
        ),
        IconButton(
          onPressed: _onCreateFile,
          icon: Icon(Icons.insert_drive_file),
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
    FileSystemEntity item = _list![index];
    if (item is Directory) {
      return DocItemView(
        dir: item,
        onSelect: _onItemSelect,
        onExpend: _onItemExpend,
      );
    }
    if (item is File) {
      return FileItemView(
        file: item,
        onSelect: _onItemSelect,
      );
    }
    return UnKnowView(object: item);
  }

  void _onCreateDoc() {
    showCustomInputBasicDialog(
      hintText: '请输入文件夹名',
      autoHiddenDialog: true,
      confirmCallback: (String value) async {
        Directory dir = await optionManager.createDirInCurrent(value);
        optionManager.toggleDirExpend(dir.parent, expend: true);
        _queryItems();
      },
    );
  }

  void _onCreateFile() {
    showCustomInputBasicDialog(
      hintText: '请输入文件名',
      autoHiddenDialog: true,
      confirmCallback: (value) async {
        File file = await optionManager.createFileInCurrent(value);
        optionManager.toggleDirExpend(file.parent, expend: true);
        _queryItems();
      },
    );
  }

  void _onItemSelect(selectedItem) {
    optionManager.changeSelectedItem(selectedItem);
    setState(() {});
  }

  void _onItemExpend(selectedItem) {
    optionManager.toggleDirExpend(selectedItem);
    setState(() {});
  }
}
