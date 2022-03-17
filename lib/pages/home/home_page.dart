import 'package:moflu/model/json/home.dart';
import 'package:moflu/pages/home/object/option_manager.dart';
import 'package:moflu/pages/home/views/doc_view.dart';
import 'package:moflu/supports/widgets/dialogs/dialog_common_input_widget.dart';
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
    docEventBus.on<DocEventItem>().listen((event) {
      if (event.docId == null) {
        setState(() {});
      }
    });
  }

  void _queryItems() {
    dbHelper.selectDocs(null).then((value) {
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
    CBDoc doc = _list![index];
    return DocItemView(
      doc: doc,
      onSelect: _onItemSelect,
      onExpend: _onItemExpend,
    );
  }

  void _onCreateDoc() {
    showCustomInputBasicDialog(
      hintText: '请输入文件夹名',
      autoHiddenDialog: true,
      confirmCallback: (String value) {
        CBDoc doc = CBDoc.fromCreate(value, optionManager.selectedDocId);
        optionManager.toggleDocExpend(optionManager.selectedDocId,
            expend: true);
        dbHelper.insertDoc(doc).then((value) {
          _queryItems();
        });
      },
    );
  }

  void _onCreateFile() {
    showCustomInputBasicDialog(
      hintText: '请输入文件名',
      autoHiddenDialog: true,
      confirmCallback: (value) {
        CBFile file = CBFile.fromCreate(value, optionManager.selectedDocId);
        optionManager.toggleDocExpend(optionManager.selectedDocId,
            expend: true);
        dbHelper.insertFile(file).then((value) {
          _queryItems();
        });
      },
    );
  }

  void _onItemSelect(selectedItem) {
    optionManager.changeSelectedItem(selectedItem);
    setState(() {});
  }

  void _onItemExpend(selectedItem) {
    optionManager.toggleDocExpend(selectedItem);
    setState(() {});
  }
}
