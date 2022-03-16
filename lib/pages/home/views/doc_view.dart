import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moflu/model/json/home.dart';
import 'package:moflu/model/sqlite/data_base.dart';
import 'package:moflu/pages/home/object/option_manager.dart';
import 'package:moflu/pages/home/views/file_view.dart';
import 'package:moflu/pages/home/views/unknow_view.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/dialogs/dialog_common_wedgets.dart';
import 'package:moflu/supports/widgets/divider.dart';
import 'package:moflu/supports/widgets/space.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';

typedef DocItemCallback = void Function(dynamic selectedItem);

class DocItemView extends StatefulWidget {
  final CBDoc doc;
  final int level;
  final DocItemCallback? onSelect;
  final DocItemCallback? onExpend;

  const DocItemView({
    Key? key,
    required this.doc,
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
    if (optionManager.isDocExpend(widget.doc.id)) {
      dbHelper.selectAllItems(widget.doc.id).then((value) {
        _list = value;
        setState(() {});
      });
    } else {
      _list = null;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    docEventBus.on<DocEventItem>().listen((event) {
      if (event.docId == widget.doc.id) {
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
    columns.add(_buildDocItem(
      context,
      widget.doc,
      optionManager.isDocExpend(widget.doc.id),
      optionManager.isItemSelect(widget.doc.id),
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
    if (item is CBDoc) {
      return DocItemView(
        doc: item,
        level: widget.level + 1,
        onSelect: _onItemSelect,
        onExpend: _onItemExpend,
      );
    }
    if (item is CBFile) {
      return FileItemView(
        file: item,
        level: widget.level + 1,
        onSelect: _onItemSelect,
      );
    }
    return UnKnowView(object: item);
  }

  Widget _buildDocItem(
      BuildContext context, CBDoc doc, bool expend, bool selected, int level) {
    return _slidable(
      context,
      doc,
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
                  SimpleText(doc.name),
                ],
              ),
            ),
            CBDivider.h(),
          ],
        ),
      ),
    );
  }

  Widget _slidable(BuildContext context, CBDoc doc, Widget child) {
    return Slidable(
      key: Key(doc.id),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showCustomBasicDialog(
                  content: '是否删除此文件夹以及其内的所有文件',
                  confirmCallback: () {
                    dbHelper.deleteDoc(doc.id).then((value) {
                      optionManager.refreshDoc(doc.inDocId);
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
      widget.onSelect!(widget.doc);
    }
  }

  void _onExpend() {
    if (widget.onExpend != null) {
      widget.onExpend!(widget.doc);
    }
  }

  void _onItemSelect(selectedItem) {
    if (widget.onSelect != null) {
      widget.onSelect!(selectedItem);
    }
  }

  void _onItemExpend(selectedItem) {
    optionManager.toggleDocExpend(selectedItem);
    setState(() {});
  }
}
