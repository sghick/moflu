import 'package:moflu/model/sqlite/data_base.dart';

OptionManager optionManager = OptionManager();

class OptionManager {
  String? selectedItemId;
  String? selectedDocId;
  Map<String, bool> docExpend = {};

  void changeSelectedItem(dynamic item) {
    String _selectedItemId = '';
    if (item is CBDoc) {
      selectedDocId = item.id;
      _selectedItemId = item.id;
    }
    if (item is CBFile) {
      selectedDocId = item.inDocId;
      _selectedItemId = item.id;
    }

    if (selectedItemId != _selectedItemId) {
      selectedItemId = _selectedItemId;
    } else {
      selectedItemId = null;
    }
  }

  void toggleDocExpend(dynamic item, {bool? expend}) {
    if (item is CBDoc) {
      docExpend[item.id] = expend ?? !isDocExpend(item.id);
    }
    if (item is String) {
      docExpend[item] = expend ?? !isDocExpend(item);
    }
  }

  bool isDocExpend(String id) {
    bool? _expend = docExpend[id];
    return _expend ?? false;
  }

  bool isItemSelect(String id) {
    return selectedItemId == id;
  }
}
