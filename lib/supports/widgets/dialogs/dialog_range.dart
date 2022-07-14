import 'package:moflu/supports/widgets/dialogs/cupertino_picker_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rego/base_core/utils/screen_utils.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';

Future<int> showRangePicker(
  BuildContext context,
  int initial,
  int start,
  int end,
  int step,
  String? symbol,
) {
  List<String> list = [];
  for (int i = start; i <= end; i += step) {
    list.add('$i${symbol ?? ''}');
  }
  int selectedItem = list.indexOf('$initial${symbol ?? ''}');
  FixedExtentScrollController controller =
      FixedExtentScrollController(initialItem: selectedItem);
  return showCupertinoModalPopup<int>(
      context: context,
      builder: (context) {
        return CupertinoPickerContainer(
          controller: controller,
          picker: CupertinoPicker.builder(
            scrollController: controller,
            childCount: list.length,
            itemExtent: 30.dp,
            onSelectedItemChanged: (int index) {
              selectedItem = index;
            },
            itemBuilder: (BuildContext context, int index) {
              return SimpleText(
                list[index],
                bkgColor: Colors.white,
              );
            },
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              capLeftEdge: false,
              capRightEdge: false,
            ),
          ),
        );
      }).then((index) {
    return start + selectedItem;
  });
}
