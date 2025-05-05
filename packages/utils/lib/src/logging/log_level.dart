enum LogLevel { debug, info, warning, error }

extension LogLevelExtension on LogLevel {
  String get label {
    switch (this) {
      case LogLevel.debug:
        return "🐞 DEBUG";
      case LogLevel.info:
        return "ℹ️ INFO";
      case LogLevel.warning:
        return "⚠️ WARNING";
      case LogLevel.error:
        return "⛔️ ERROR";
    }
  }
}
