import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> cbToast({required String msg}) {
  return Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
}
