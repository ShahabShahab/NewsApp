import 'package:code_challenge_news_app/core/logging/log_level.dart';
import 'package:flutter/foundation.dart';

class Logger {
  static void log(
    String message, {
    LogLevel level = LogLevel.debug,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      final lineOfCode = _getLineOfCode();
      final callerInfo = _getCallerInfo();
      debugPrint("[${level.label}] [$lineOfCode] [$callerInfo] : $message");

      if (error != null) debugPrint("Error: $error");
      if (stackTrace != null) debugPrint("StackTrace: $stackTrace");
    }
  }

  static void debug(String message) => log(message, level: LogLevel.debug);

  static void info(String message) => log(message, level: LogLevel.info);

  static void warning(String message) => log(message, level: LogLevel.warning);

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    log(message, level: LogLevel.error, error: error, stackTrace: stackTrace);
  }


  static String _getCallerInfo() {
    final traceString = StackTrace.current.toString().split('\n');

    if (traceString.length > 3) {
      final callerFrame = traceString[3];

      final regex = RegExp(r'#\d+\s+([^. ]+)\.([^\s]+)');
      final match = regex.firstMatch(callerFrame);

      if (match != null && match.groupCount >= 2) {
        final className = match.group(1);
        final methodName = match.group(2);
        return '$className.$methodName';
      }
    }

    return "UnknownCaller";
  }

  static String _getLineOfCode() {
    final trace = StackTrace.current.toString().split("\n")[3];
    final callerInfo =
        trace.substring(trace.indexOf('(')).replaceAll(")", "").trim();
    return callerInfo;
  }
}
