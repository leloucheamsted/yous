class LoggerConfig {
  const LoggerConfig({
    required this.sentryDsn,
    required this.environment,
    required this.clearLogIntervalMs,
    this.logAttachmentName = 'youscribe-logs',
  });

  /// The DSN tells the SDK where to send the events to.
  /// If an empty string is used, the SDK will not send any events.
  final String sentryDsn;

  /// Sets the environment. This string is freeform and not set by default.
  /// A release can be associated with more than one environment to
  /// separate them in the UI Think staging vs prod or similar.
  final String environment;

  /// A interval in milliseconds to clear the logs.
  /// This will delete all logs that are older than this interval.
  final int clearLogIntervalMs;

  /// The name of the log file attachment.
  /// This will be the name of the file that is attached to the Sentry event.
  final String logAttachmentName;
}
