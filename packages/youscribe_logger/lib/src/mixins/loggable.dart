import 'package:youscribe_logger/src/logger/logger.dart';
import 'package:youscribe_logger/src/mixins/debuggable.dart';

mixin Loggable on Debuggable {
  /// Access the logger instance from anywhere
  /// in the class that uses this mixin
  ///
  /// Useful to configure the logger, but if you want to log
  /// something, you should use the `logError`, `logWarning`... which
  /// will automatically add the class name.
  Logger get logger => Logger.instance;

  void logError(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? methodName,
  }) =>
      logger.error(
        message,
        error: error,
        stackTrace: stackTrace,
        className: debugName,
        methodName: methodName,
      );

  void logWarning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? methodName,
  }) =>
      logger.warning(
        message,
        error: error,
        stackTrace: stackTrace,
        className: debugName,
        methodName: methodName,
      );

  void logDebug(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? methodName,
  }) =>
      logger.log(
        message,
        error: error,
        stackTrace: stackTrace,
        className: debugName,
        methodName: methodName,
      );

  void logInfo(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? methodName,
  }) =>
      logger.info(
        message,
        error: error,
        stackTrace: stackTrace,
        className: debugName,
        methodName: methodName,
      );
}
