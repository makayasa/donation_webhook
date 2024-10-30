// import 'package:logger/logger.dart';

// abstract class MyLogFilter {
//   Level? _level;

//   // Still nullable for backwards compatibility.
//   Level? get level => _level ?? Logger.level;

//   set level(Level? value) => _level = value;

//   Future<void> init() async {}

//   /// Is called every time a new log message is sent and decides if
//   /// it will be printed or canceled.
//   ///
//   /// Returns `true` if the message should be logged.
//   bool shouldLog(LogEvent event);

//   Future<void> destroy() async {}
// }

import 'package:logger/logger.dart';

class MyLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}
