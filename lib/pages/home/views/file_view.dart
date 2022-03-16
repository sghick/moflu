import 'package:flutter/material.dart';
import 'package:moflu/model/json/home.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/divider.dart';
import 'package:moflu/supports/widgets/space.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';

typedef FileItemCallback = void Function(dynamic selectedItem);

class FileItemView extends StatefulWidget {
  final CBFile file;
  final int level;
  final bool selected;
  final FileItemCallback? onSelect;

  const FileItemView({
    Key? key,
    required this.file,
    this.level = 0,
    this.onSelect,
    this.selected = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FileItemViewState();
}

class _FileItemViewState extends State<FileItemView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onSelect,
      child: Column(
        children: [
          _buildFileItem(widget.file, widget.selected, widget.level),
        ],
      ),
    );
  }

  Widget _buildFileItem(CBFile file, bool selected, int level) {
    return Container(
      color: selected ? Colors.blue[100] : Colors.transparent,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: 20.dp, right: 20.dp, top: 5.dp, bottom: 5.dp),
            child: Row(
              children: [
                CBSpace.h(level * 20.dp),
                Icon(
                  Icons.insert_drive_file,
                  color: Colors.lightBlue,
                ),
                CBSpace.h(10.dp),
                SimpleText(file.name),
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
      widget.onSelect!(widget.file);
    }
  }
}
