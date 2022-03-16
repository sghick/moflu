import 'package:flutter/material.dart';
import 'package:moflu/model/json/home.dart';
import 'package:moflu/pages/home/object/option_manager.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/divider.dart';
import 'package:moflu/supports/widgets/space.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';

typedef FileItemCallback = void Function(dynamic selectedItem);

class FileItemView extends StatefulWidget {
  final CBFile file;
  final int level;
  final FileItemCallback? onSelect;

  const FileItemView({
    Key? key,
    required this.file,
    this.level = 0,
    this.onSelect,
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
          _buildFileItem(widget.file,
              optionManager.isItemSelect(widget.file.id), widget.level),
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
            margin: EdgeInsets.all(5.dp),
            child: Row(
              children: [
                CBSpace.h(level * 20.dp),
                Icon(
                  Icons.insert_drive_file,
                  color: Colors.green,
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
