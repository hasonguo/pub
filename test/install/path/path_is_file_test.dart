// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS d.file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE d.file.

import 'package:pathos/path.dart' as path;
import 'package:scheduled_test/scheduled_test.dart';

import '../../descriptor.dart' as d;
import '../../test_pub.dart';

main() {
  initConfig();
  integration('path dependency when path is a file', () {
    d.dir('foo', [
      d.libDir('foo'),
      d.libPubspec('foo', '0.0.1')
    ]).create();

    d.file('dummy.txt', '').create();
    var dummyPath = path.join(sandboxDir, 'dummy.txt');

    d.dir(appPath, [
      d.pubspec({
        "name": "myapp",
        "dependencies": {
          "foo": {"path": dummyPath}
        }
      })
    ]).create();

    pubInstall(error: "Path dependency for package 'foo' must refer to a "
                      "directory, not a file. Was '$dummyPath'.");
  });
}