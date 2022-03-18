import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:path_provider/path_provider.dart';

OptionManager optionManager = OptionManager();

class OptionManager {
  FileSystemEntity? selectedItem;
  Directory? inDir;
  Map<String, bool> docExpend = {};

  Future<Directory> get rootDir =>
      getApplicationDocumentsDirectory().then((value) {
        Directory directory = Directory(value.path + '/moflu');
        if (directory.existsSync()) {
          return directory;
        } else {
          return directory.create();
        }
      });

  Future<Directory> createDir(Directory? inDir, String name) {
    if (inDir != null) {
      Directory dir = Directory(inDir.path + '/' + name);
      return dir.create(recursive: true);
    } else {
      return rootDir.then((value) => createDir(value, name));
    }
  }

  Future<Directory> createDirInCurrent(String name) {
    return createDir(inDir, name);
  }

  Future<File> createFile(Directory? inDir, String name, {String? ext}) {
    if (inDir != null) {
      File file = File(inDir.path + '/' + name + (ext ?? ''));
      return file.create(recursive: true);
    } else {
      return rootDir.then((value) => createFile(value, name, ext: ext));
    }
  }

  Future<File> createFileInCurrent(String name, {String? ext}) {
    return createFile(inDir, name, ext: ext);
  }

  void changeSelectedItem(FileSystemEntity item) {
    if (item is Directory) {
      inDir = item;
    }
    if (item is File) {
      inDir = item.parent;
    }
    if ((selectedItem != null) && (selectedItem!.path != item.path)) {
      selectedItem = item;
    } else {
      selectedItem = null;
    }
  }

  void toggleDirExpend(Directory item, {bool? expend}) {
    docExpend[item.path] = expend ?? !isDirExpend(item);
  }

  bool isDirExpend(Directory dir) {
    bool? _expend = docExpend[dir.path];
    return _expend ?? false;
  }

  bool isItemSelect(FileSystemEntity item) {
    return (selectedItem?.path ?? '') == item.path;
  }

  void refreshDir(Directory? dir) {
    docEventBus.fire(DocEventItem(dir));
  }
}

final docEventBus = EventBus();

class DocEventItem {
  final Directory? dir;

  DocEventItem(this.dir);
}
