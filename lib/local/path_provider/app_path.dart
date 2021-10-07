import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AppPath {
  static Future<String> internalAppDocsPath() async {
    Directory _dir = await getApplicationDocumentsDirectory();
    return _dir.path;
  }

  static String joinPath({@required List<String> pathSnippets}) {
    String _path = '';

    if (pathSnippets.length > 0)
      pathSnippets.forEach((snippet) {
        _path = join(_path, snippet);
      });

    return _path;
  }
}
