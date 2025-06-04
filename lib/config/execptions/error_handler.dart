// error_handler.dart
import 'dart:async';
import 'package:flutter/foundation.dart';

class ErrorHandler {
  static void initialize(void Function() appStartCallback) {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      debugPrint('❌ FlutterError: ${details.exception}');
      debugPrintStack(stackTrace: details.stack);
    };

    runZonedGuarded(() {
      appStartCallback();
    }, (Object error, StackTrace stackTrace) {
      debugPrint('❌ Uncaught Zone Error: $error');
      debugPrintStack(stackTrace: stackTrace);
    });
  }

  static void catchAndLog(Function callback) {
    try {
      callback();
    } catch (e, stack) {
      debugPrint('❌ Exception: $e');
      debugPrintStack(stackTrace: stack);
    }
  }

  static Future<void> catchAsync(Future<void> Function() callback) async {
    try {
      await callback();
    } catch (e, stack) {
      debugPrint('❌ Async Exception: $e');
      debugPrintStack(stackTrace: stack);
    }
  }
}
