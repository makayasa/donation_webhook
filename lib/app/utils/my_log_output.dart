import 'dart:io';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:saweria_webhook/app/utils/network_controller.dart';

class MyLogOutput extends LogOutput {
  @override
  void output(OutputEvent event) async {
    final networkC = Get.find<NetworkController>();
    final file = networkC.logFile;
    for (var line in event.lines) {
      file.writeAsStringSync('$line\n', mode: FileMode.writeOnlyAppend);
      print(line);
    }
  }

  @override
  Future<void> init() async {
    // Directory a = await getApplicationDocumentsDirectory();
    // filepath = a.path;
    // file = File('$filepath');
    return super.init();
  }
}
