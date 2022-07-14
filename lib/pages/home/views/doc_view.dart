import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moflu/pages/home/object/option_manager.dart';
import 'package:moflu/pages/home/views/file_view.dart';
import 'package:moflu/pages/home/views/unknow_view.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/dialogs/dialog_common_wedgets.dart';
import 'package:moflu/supports/widgets/divider.dart';
import 'package:moflu/supports/widgets/space.dart';
import 'package:moflu/supports/widgets/toast.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';

typedef DocItemCallback = void Function(dynamic selectedItem);

class DocItemView extends StatefulWidget {
  final Directory dir;
  final int level;
  final DocItemCallback? onSelect;
  final DocItemCallback? onExpend;

  const DocItemView({
    Key? key,
    required this.dir,
    this.level = 0,
    this.onSelect,
    this.onExpend,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DocItemViewState();
}

class _DocItemViewState extends State<DocItemView> {
  List? _list;

  void _refreshList() {
    if (optionManager.isDirExpend(widget.dir)) {
      _list = widget.dir.listSync().toList();
    } else {
      _list = null;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    docEventBus.on<DocEventItem>().listen((event) {
      if ((event.dir != null) && (event.dir!.path == widget.dir.path)) {
        _refreshList();
      }
    });
  }

  @override
  void didUpdateWidget(covariant DocItemView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columns = [];
    columns.add(_buildDirItem(
      context,
      widget.dir,
      optionManager.isDirExpend(widget.dir),
      optionManager.isItemSelect(widget.dir),
      widget.level,
    ));
    for (int i = 0; i < (_list?.length ?? 0); i++) {
      columns.add(_buildItems(context, i));
    }
    return GestureDetector(
      onTap: _onSelect,
      child: Column(children: columns),
    );
  }

  Widget _buildItems(context, index) {
    var item = _list![index];
    if (item is Directory) {
      return DocItemView(
        dir: item,
        level: widget.level + 1,
        onSelect: _onItemSelect,
        onExpend: _onItemExpend,
      );
    }
    if (item is File) {
      return FileItemView(
        file: item,
        level: widget.level + 1,
        onSelect: _onItemSelect,
      );
    }
    return UnKnowView(object: item);
  }

  Widget _buildDirItem(BuildContext context, Directory dir, bool expend,
      bool selected, int level) {
    return _slidable(
      context,
      dir,
      Container(
        color: selected ? Colors.blue[100] : Colors.transparent,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5.dp),
              child: Row(
                children: [
                  CBSpace.h(widget.level * 20.dp),
                  GestureDetector(
                    onTap: _onExpend,
                    child: Row(
                      children: [
                        Icon(
                          expend
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          color: Colors.lightBlue,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.work,
                    color: Colors.lightBlue,
                  ),
                  CBSpace.h(5.dp),
                  SimpleText(dir.path.lastPath),
                ],
              ),
            ),
            CBDivider.h(),
          ],
        ),
      ),
    );
  }

  Widget _slidable(BuildContext context, Directory dir, Widget child) {
    return Slidable(
      key: Key(dir.path),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showCustomBasicDialog(
                  content: '是否删除此文件夹以及其内的所有文件',
                  confirmCallback: () {
                    widget.dir.delete(recursive: true).then((value) {
                      cbToast(msg: '删除成功');
                      optionManager.refreshDir(widget.dir.parent);
                    });
                  });
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: child,
    );
  }

  void _onSelect() {
    if (widget.onSelect != null) {
      widget.onSelect!(widget.dir);
    }
  }

  void _onExpend() {
    if (widget.onExpend != null) {
      widget.onExpend!(widget.dir);
    }
  }

  void _onItemSelect(selectedItem) {
    if (widget.onSelect != null) {
      widget.onSelect!(selectedItem);
    }
  }

  void _onItemExpend(selectedItem) {
    optionManager.toggleDirExpend(selectedItem);
    setState(() {});
  }
}
