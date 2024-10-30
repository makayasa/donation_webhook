import 'dart:io';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:loggy/loggy.dart' hide AnsiColor;
import 'package:saweria_webhook/app/utils/network_controller.dart';

class MyLogPrinter extends LoggyPrinter {
  static final _levelPrefixes = {
    LogLevel.debug: '🐛 ',
    LogLevel.info: '👻 ',
    LogLevel.warning: '⚠️ ',
    LogLevel.error: '‼️ ',
  };

  static final _levelColors = {
    LogLevel.debug: const AnsiColor.fg(135),
    LogLevel.info: const AnsiColor.fg(35),
    LogLevel.warning: const AnsiColor.fg(214),
    LogLevel.error: const AnsiColor.fg(196),
  };

  static const _defaultPrefix = '🤔 ';

  @override
  void onLog(LogRecord record) {
    // TODO: implement onLog
    // final color = AnsiColor(foregroundColor: 135);
    final prefix = levelPrefix(record.level) ?? _defaultPrefix;

    final time = record.time.toIso8601String().split('T')[1];
    final callerFrame = record.callerFrame == null ? '-' : '(${record.callerFrame?.location})';

    final logLevel = record.level.toString().replaceAll('Level.', '').toUpperCase().padRight(8);

    final color = levelColor(record.level) ?? const AnsiColor.none();

    final text='$prefix$time $logLevel ${record.loggerName} $callerFrame ${record.message}';

    print(color(text));
    final networkC = Get.find<NetworkController>();
    networkC.logFile.writeAsStringSync(text,mode: FileMode.writeOnlyAppend);

    // print(color('test').toString());
    // final String test = color('test');
    // print(test);
  }

  String? levelPrefix(LogLevel level) {
    return _levelPrefixes[level];
  }

  AnsiColor? levelColor(LogLevel level) {
    return _levelColors[level];
  }
}
