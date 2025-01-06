// ignore_for_file: avoid_void_async

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:provider/provider.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/page_turned_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/helpers/app_state_helpers/app_state_manager.dart';
import 'package:youscribe/core/helpers/app_state_helpers/app_states.dart';
import 'package:youscribe/core/use_cases/products/product_read_use_case.dart';
import 'package:youscribe/core/use_cases/reader/save_bookmark_use_case.dart';
import 'package:youscribe/infrastructure/service/reader_stats_service.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/ys_method_channel.dart';

abstract final class PdfReaderHelper {
  static StreamSubscription<AppStates>? _appStateSubscription;
  static ReaderStatsService get _readerStatsService => locator();
  static final ProductReadUseCase _productReadUseCase = locator();
  static int _pageCount = 0;
  static int _currentProductId = 0;

  static Future<void> showDocument(
    BuildContext context,
    ProductEntity product,
    String documentPath,
    String? password, {
    int startPage = 0,
  }) async {
    //NOTE: To display the PDF reader in a flutter widget,
    //use this:
    /** 
     return Scaffold(
      body: SafeArea(
          child: PspdfkitWidget(
        documentPath: documentPath,
        configuration: PspdfkitConfiguration(
          password: password,
    */

    _pageCount = 0;
    _currentProductId = product.id!;

    //NOTE: These events fire only on iOS
    if (Platform.isIOS) {
      Pspdfkit.onPageChanged ??= _onPageChanged;
      Pspdfkit.onDocumentLoaded ??= _onDocumentLoaded;

      Pspdfkit.pdfViewControllerDidDismiss ??= _onPdfExited;
      Pspdfkit.flutterPdfActivityOnDestroy ??= _onPdfExited;
      Pspdfkit.flutterPdfActivityOnPause ??=
          () => _onPauseOrResume(true, false);
      Pspdfkit.flutterPdfActivityOnResume ??=
          () => _onPauseOrResume(false, true);
      _appStateSubscription =
          AppStateManager.stateController.listen(_onAppStateChanged);
    } else {
      YSMethodChannel.instance.flutterPdfActivityOnDestroy ??= _onPdfExited;
      YSMethodChannel.instance.onDocumentLoaded ??= _onDocumentLoaded;
      YSMethodChannel.instance.onPageChanged ??= _onPageChanged;
      YSMethodChannel.instance.pdfViewControllerDidDismiss ??= _onPdfExited;
      YSMethodChannel.instance.flutterPdfActivityOnPause ??=
          () => _onPauseOrResume(true, false);
      YSMethodChannel.instance.flutterPdfActivityOnResume ??=
          () => _onPauseOrResume(false, true);
    }

    await _productReadUseCase(ProductReadUseCaseParams(product));

    final configuration = PspdfkitConfiguration(
      password: password,

      /// Common options
      enableAnnotationEditing: false,
      iOSAllowToolbarTitleChange: false,
      startPage: startPage,
      showActionNavigationButtons: false,
      settingsMenuItems: [
        SettingsMenuItem.androidScreenAwake,
        SettingsMenuItem.iOSBrightness,
      ],
      disableAutosave: true,

      /// IOS options
      iOSRightBarButtonItems: [
        IOSBarButtonsItem.thumbnailsButtonItem,
        // IOSBarButtonsItem.outlineButtonItem,
        IOSBarButtonsItem.bookmarkButtonItem,
        IOSBarButtonsItem.searchButtonItem,
      ],

      iOSLeftBarButtonItems: [
        IOSBarButtonsItem.settingsButtonItem,
      ],

      /// Android options
      androidGrayScale: false,
      androidEnableDocumentEditor: false,
      androidShowAnnotationListAction: false,
      androidShowDocumentInfoView: false,
      androidShowPrintAction: false,
      androidShowShareAction: false,
      androidShowOutlineAction: true,
      androidShowThumbnailGridAction: true,
      androidShowBookmarksAction: true,
      androidShowSearchAction: true,
      androidDefaultThemeResource:
          // ignore: use_build_context_synchronously
          Provider.of<YouScribeTheme>(context, listen: false).isDarkMode
              ? 'PSPDFKit.Theme.Custom.Dark'
              : 'PSPDFKit.Theme.Custom.Light',
    );

    if (_appStateSubscription != null) {
      await _appStateSubscription!.cancel();
    }

    await Pspdfkit.present(
      documentPath,
      configuration: configuration,
    );

    _readerStatsService.startReading(product.id!);
    //Keep the screen on.
    await KeepScreenOn.turnOn();
  }

  static void _onPageChanged(int oldPageIndex, int newPageIndex) async {
    //print('### Page changed $oldPageIndex new: $newPageIndex');
    if (oldPageIndex == -1) {
      return;
    }

    final percentage = (newPageIndex / _pageCount) * 100;
    final SaveBookmarkUseCase saveBookmarkUseCase = locator();
    await saveBookmarkUseCase(SaveBookmarkUseCaseParameters(
        productId: _currentProductId,
        pageNumber: newPageIndex,
        progress: percentage));

    await _readerStatsService.pageChanged(PageTurnedEntity(
        percent: percentage,
        pageSize: (ReaderStatsService.bookParts / 2) / _pageCount,
        pagePosition: newPageIndex.toDouble(),
        idRef: newPageIndex.toString(),
        currentPage: newPageIndex));
  }

  static void _onDocumentLoaded(String documentId, int pageCount) async {
    if (kDebugMode) {
      print('### Document Loaded: Id: $documentId page: $pageCount');
    }
    _pageCount = pageCount;
  }

  static Future<void> _onPauseOrResume(bool isPaused, bool isResumed) async {
    if (isPaused) {
      await _readerStatsService.stopReading();
      //Stop keeping the screen on.
      await KeepScreenOn.turnOff();
    } else if (isResumed) {
      _readerStatsService.resumeReading();
      //Stop keeping the screen on.
      await KeepScreenOn.turnOn();
    }
  }

  static Future<void> _onAppStateChanged(AppStates state) async {
    //NOTE: Appstate changes from pause to resume won't work here
    //Because, the PDF is in another activity, causing the app to pause
    //Systematically when the pdf page is opened, so listening to these state
    //changes is useless since the data is wrong.

    // if (state == AppStates.paused) {
    //   await _readerStatsService.stopReading();
    //   //Stop keeping the screen on.
    //   await KeepScreenOn.turnOff();
    // } else if (state == AppStates.active) {
    //   _readerStatsService.resumeReading();
    //   //Stop keeping the screen on.
    //   await KeepScreenOn.turnOn();
    // }
  }

  static void _onPdfExited() async {
    if (kDebugMode) {
      print('### PDF Exited');
    }
    if (_appStateSubscription != null) {
      //Stop keeping the screen on.
      await KeepScreenOn.turnOff();
      await _appStateSubscription!.cancel();
      _appStateSubscription = null;
      await _readerStatsService.stopReading();
    }
  }
}
