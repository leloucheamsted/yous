import 'dart:async';

import 'package:my_logger/logger.dart';
import 'package:my_logger/logger_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:youscribe_logger/src/logger/logger_config.dart';

abstract class Logger {
  const Logger._(this.config);

  static Logger? _instance;

  /// Get the logger instance
  ///
  /// Throws an exception if the instance is not initialized
  static Logger get instance {
    if (_instance == null) {
      throw Exception('Logger instance is not initialized');
    }
    return _instance!;
  }

  /// Set the logger instance
  ///
  /// This is useful for testing purposes
  static set instance(Logger logger) => _instance = logger;

  /// Initialize the logger
  static Future<void> init(LoggerConfig config) async {
    _instance = LoggerImpl(config);

    await _instance!._initialize();
  }

  final LoggerConfig config;

  Future<void> _initialize();

  /// Bind the user infos to the logger
  Future<void> setUserInfos({
    required String? id,
    required String? email,
  });

  // Unbind the user infos from the logger
  Future<void> unsetUserInfos() => setUserInfos(id: null, email: null);

  /// Handles exceptions
  Future<void> handleException(
    Object exception, {
    StackTrace? stackTrace,
    String? className,
    String? methodName,
  });

  /// Exports the log
  Future<void> exportLogs();

  /// Check if the logger is initialized
  static bool get isInitialized => _instance != null;

  /// Dispose the logger
  Future<void> dispose() async {
    await exportLogs();
    _instance = null;
  }

  /// Get the path of the log file
  Future<String> get logFilePath;

  void log(
    String message, {
    Object? error,
    LogLevel? type,
    StackTrace? stackTrace,
    String? className,
    String? methodName,
  });

  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? className,
    String? methodName,
  }) =>
      log(
        message,
        type: LogLevel.ERROR,
        error: error,
        stackTrace: stackTrace,
        className: className,
        methodName: methodName,
      );

  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? className,
    String? methodName,
  }) =>
      log(
        message,
        type: LogLevel.WARNING,
        error: error,
        stackTrace: stackTrace,
        className: className,
        methodName: methodName,
      );

  void debug(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? className,
    String? methodName,
  }) =>
      log(
        message,
        type: LogLevel.DEBUG,
        error: error,
        stackTrace: stackTrace,
        className: className,
        methodName: methodName,
      );

  void info(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? className,
    String? methodName,
  }) =>
      log(
        message,
        type: LogLevel.INFO,
        error: error,
        stackTrace: stackTrace,
        className: className,
        methodName: methodName,
      );
}

/// Implementation of the Logger using FLogs and Sentry
class LoggerImpl extends Logger {
  LoggerImpl(super.config) : super._();

  String? userId;
  String? userEmail;

  @override
  Future<void> _initialize() async {
    // Configure logger
    final LogConfig logConfig = MyLogger.config
      ..outputFormat =
          '''{{time}} {{level}} [{{class}}:{{method}}] {{message}} {{exception}} {{stacktrace}}'''
      ..dataLogTypeValues = DataLogType.values
      ..timestampFormat = TimestampFormat.DEFAULT;

    MyLogger.applyConfig(logConfig);

    // Remove old logs
    MyLogger.logs.deleteByFilter(
      LogFilter(
        startDateTime: DateTime.now()
            .subtract(Duration(milliseconds: config.clearLogIntervalMs)),
      ),
    );

    await SentryFlutter.init(
      (options) {
        options
          ..dsn = config.sentryDsn
          ..environment = config.environment
          ..tracesSampleRate = 1.0;
      },
    );

    await exportLogs();
  }

  @override
  void log(
    String message, {
    Object? error,
    LogLevel? type,
    StackTrace? stackTrace,
    String? className,
    String? methodName,
  }) {
    final member = Trace.current().frames[3].member ?? '';

    final method =
        methodName ?? (member.contains('.') ? member.split('.')[1] : member);

    return MyLogger.log(
      text: message,
      type: LogLevel.INFO,
      className: className,
      methodName: method,
      exception: error,
      stacktrace: stackTrace,
    );
  }

  @override
  Future<void> handleException(
    Object exception, {
    StackTrace? stackTrace,
    String? className,
    String? methodName,
  }) async {
    await exportLogs();

    final error =
        exception is Exception ? exception : Exception(exception.toString());
    MyLogger.log(
      text: 'Unhandled exception',
      type: LogLevel.ERROR,
      className: className,
      methodName: methodName,
      exception: error,
      stacktrace: stackTrace,
    );

    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }

  @override
  Future<void> setUserInfos({
    required String? id,
    required String? email,
  }) async {
    userId = id;
    userEmail = email;

    final sentryUser =
        id != null && email != null ? SentryUser(id: id, email: email) : null;

    Sentry.configureScope(
      (scope) => scope.setUser(sentryUser),
    );
  }

  @override
  Future<void> exportLogs() async {
    final logFilePath = await this.logFilePath;
    debug('Exporting logs to $logFilePath');
    final file = await MyLogger.logs.export(
      fileName: config.logAttachmentName,
      exportType: FileType.TXT,
    );
    Sentry.configureScope((scope) async {
      await scope.clear();

      if (userId != null && userEmail != null) {
        await scope.setUser(
          SentryUser(
            id: userId,
            email: userEmail,
          ),
        );
      }

      scope.addAttachment(
        SentryAttachment.fromIntList(
          file.readAsBytesSync(),
          config.logAttachmentName,
        ),
      );
    });
  }

  @override
  Future<String> get logFilePath async {
    final directory = await LogsExporter.instance.getDefaultPath();

    return '$directory/${config.logAttachmentName}.txt';
  }
}
