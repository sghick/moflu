import 'package:flutter/material.dart';
import 'package:moflu/model/json/home.dart';
import 'package:moflu/model/sqlite/data_base.dart';
import 'package:moflu/pages/home/views/file_view.dart';
import 'package:moflu/pages/home/views/unknow_view.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/divider.dart';
import 'package:moflu/supports/widgets/space.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';

typedef DocItemCallback = void Function(dynamic selectedItem);

class DocItemView extends StatefulWidget {
  final CBDoc doc;
  final int level;
  final bool selected;
  final DocItemCallback? onSelect;

  const DocItemView({
    Key? key,
    required this.doc,
    this.level = 0,
    this.onSelect,
    this.selected = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DocItemViewState();
}

class _DocItemViewState extends State<DocItemView> {
  dynamic _selectedItem;
  List? _list;

  void _queryFiles() {
    dbHelper.selectFiles(widget.doc.id).then((value) {
      _list = value;
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant DocItemView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected) {
      _queryFiles();
    } else {
      _list = null;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columns = [];
    columns.add(_buildDocItem(widget.doc, widget.selected, widget.level));
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
        selected: item == _selectedItem,
        onSelect: _onChildSelect,
      );
    }
    if (item is CBFile) {
      return FileItemView(
        file: item,
        level: widget.level + 1,
        selected: item == _selectedItem,
        onSelect: _onChildSelect,
      );
    }
    return UnKnowView(object: item);
  }

  Widget _buildDocItem(CBDoc doc, bool selected, int level) {
    return Container(
      color: selected ? Colors.blue[100] : Colors.transparent,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: 20.dp, right: 20.dp, top: 5.dp, bottom: 5.dp),
            child: Row(
              children: [
                CBSpace.h(widget.level * 20.dp),
                Icon(
                  selected ? Icons.remove : Icons.add_box,
                  color: Colors.lightBlue,
                ),
                CBSpace.h(10.dp),
                SimpleText(doc.name),
                CBSpace.h(10.dp),
              ],
            ),
          ),
          CBDivider.h(),
        ],
      ),
    );
  }

  void _onSelect() {
    if (widget.onSelect != null) {
      widget.onSelect!(_selectedItem ?? widget.doc);
    }
  }

  void _onChildSelect(selectedItem) {
    _selectedItem = selectedItem;
    if (widget.onSelect != null) {
      widget.onSelect!(selectedItem);
    }
  }
}
