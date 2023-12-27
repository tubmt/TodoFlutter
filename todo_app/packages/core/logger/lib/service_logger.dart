import 'dart:developer';

class Log {
  static void d(String tag, String message) {
    _print("D", tag, message);
  }

  static void dx(Object object, String message) {
    _print("D", object.runtimeType.toString(), message);
  }

  static void e(String tag, String message) {
    _print("E", tag, message);
  }

  static void _print(String level, String tag, String message) {
    log("$tag\t\t\t($level):$message");
  }
}