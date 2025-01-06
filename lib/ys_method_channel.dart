// ignore_for_file: sort_constructors_first, constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

///Chennel used to call and receive calls from native code
///directly from the flutter project
class YSMethodChannel with Debuggable, Loggable {
  static const String YS_PSPDFKit_CHANNEL = "com.youscribe/pspdfkit";
  late MethodChannel pspdfKitMethodChannel;

  static final YSMethodChannel instance = YSMethodChannel._init();
  YSMethodChannel._init();

  @override
  String get debugName => 'YSMethodChannel';

  void configureChannel() {
    pspdfKitMethodChannel = const MethodChannel(YS_PSPDFKit_CHANNEL);
    pspdfKitMethodChannel.setMethodCallHandler(pspdfkitMethodHandler);
  }

  void Function()? flutterPdfActivityOnDestroy;
  void Function(int oldPageIndex, int newPageIndex)? onPageChanged;
  void Function(String documentId, int pageCount)? onDocumentLoaded;
  void Function()? pdfViewControllerDidDismiss;
  void Function()? flutterPdfActivityOnPause;
  void Function()? flutterPdfActivityOnResume;

  Future<void> pspdfkitMethodHandler(MethodCall call) {
    try {
      switch (call.method) {
        case 'pdfViewControllerDidDismiss':
          pdfViewControllerDidDismiss?.call();
        case 'pspdfkitPageChanged':
          {
            final Map<dynamic, dynamic> arguments =
                call.arguments as Map<dynamic, dynamic>;
            onPageChanged?.call(
              arguments['oldPageIndex'] as int,
              arguments['newPageIndex'] as int,
            );
            break;
          }
        case 'pspdfkitDocumentLoaded':
          {
            final Map<dynamic, dynamic> arguments =
                call.arguments as Map<dynamic, dynamic>;
            onDocumentLoaded?.call(
              arguments['uid'] as String,
              arguments['pageCount'] as int,
            );
            break;
          }
        case 'flutterPdfActivityOnPause':
          flutterPdfActivityOnPause?.call();
        case 'flutterPdfActivityOnResume':
          flutterPdfActivityOnResume?.call();
        case 'flutterPdfActivityOnDestroy':
          flutterPdfActivityOnDestroy?.call();

        default:
          if (kDebugMode) {
            logInfo('Unknown method ${call.method} ');
          }
      }
    } catch (e) {
      logError(
          '''Fatal error occured while handling PSPDFKit platform specific events.''',
          error: Exception(e));
      if (kDebugMode) {
        print('### Fatal error while calling method channel $e');
      }
    }
    return Future.value();
  }
}
