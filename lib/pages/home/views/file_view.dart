import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moflu/model/json/home.dart';
import 'package:moflu/model/sqlite/data_base.dart';
import 'package:moflu/pages/home/object/option_manager.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/dialogs/dialog_common_wedgets.dart';
import 'package:moflu/supports/widgets/divider.dart';
import 'package:moflu/supports/widgets/space.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';

typedef FileItemCallback = void Function(dynamic selectedItem);

class FileItemView extends StatefulWidget {
  final File file;
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
          _buildFileItem(context, widget.file,
              optionManager.isItemSelect(widget.file), widget.level),
        ],
      ),
    );
  }

  Widget _buildFileItem(
      BuildContext context, File file, bool selected, int level) {
    return _slidable(
      context,
      file,
      Container(
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
                  SimpleText(file.path.lastPath),
                  CBSpace.h(10.dp),
                ],
              ),
            ),
            CBDivider.h(),
          ],
        ),
      ),
    );
  }

  Widget _slidable(BuildContext context, File file, Widget child) {
    return Slidable(
      key: Key(file.path),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showCustomBasicDialog(
                  content: '是否删除此文件',
                  confirmCallback: () {
                    file.delete().then((value) {
                      optionManager.refreshDir(file.parent);
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
      widget.onSelect!(widget.file);
    }
  }
}
