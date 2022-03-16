import 'dart:io';

import 'package:rego/base_core/routes/navigators.dart';
import 'package:moflu/supports/widgets/dialogs/dialog_common_wedgets.dart';

Future<bool?> showPrivateDialog() {
  return showCustomBasicDialog(
    content: '隐私声明,你同不同意',
    cancelContent: '不同意',
    cancelCallback: () {
      exit(0);
    },
    confirmContent: '同意',
    isShowCloseBtn: false,
  );
}
