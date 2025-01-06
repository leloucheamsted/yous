import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/follow_item_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/use_cases/user/get_authors_followed_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_editors_followed_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_themes_followed_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_authors_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_editors_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_themes_use_case.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState>
    with Debuggable, Loggable {
  NotificationBloc() : super(NotificationInitialState()) {
    on<InitNotificationEvent>(_init);
    on<NotificationDoneEvent>(_done);

    on<DisplayedModalEvent>(_displayedModal);

    _getAuthorsFollowedUseCase = locator<GetAuthorsFollowedUseCase>();
    _getEditorsFollowedUseCase = locator<GetEditorsFollowedUseCase>();
    _getThemesFollowedUseCase = locator<GetThemesFollowedUseCase>();
    _unFollowAuthorsUseCase = locator<UnFollowAuthorsUseCase>();
    _unFollowEditorsUseCase = locator<UnFollowEditorsUseCase>();
    _unFollowThemesUseCase = locator<UnFollowThemesUseCase>();
  }

  late final GetAuthorsFollowedUseCase _getAuthorsFollowedUseCase;
  late final GetEditorsFollowedUseCase _getEditorsFollowedUseCase;
  late final GetThemesFollowedUseCase _getThemesFollowedUseCase;
  late final UnFollowAuthorsUseCase _unFollowAuthorsUseCase;
  late final UnFollowEditorsUseCase _unFollowEditorsUseCase;
  late final UnFollowThemesUseCase _unFollowThemesUseCase;
  List<FollowItemEntity> _followed = [];
  final List<FollowItemEntity> _toUnFollow = [];

  @override
  String get debugName => 'NotificationBloc';

  Future<void> _init(
      InitNotificationEvent event, Emitter<NotificationState> emitter) async {
    try {
      emitter(NotificationLoadedState(isBusy: true));

      List<FollowItemEntity> followed = [];
      if (event.options == NotificationOption.authorsOption) {
        final result = await _getAuthorsFollowedUseCase(null);
        followed = result.ok ?? [];
      } else if (event.options == NotificationOption.editorsOption) {
        final result = await _getEditorsFollowedUseCase(null);
        followed = result.ok ?? [];
      } else if (event.options == NotificationOption.themesOption) {
        final result = await _getThemesFollowedUseCase(null);
        followed = result.ok ?? [];
      }
      if (followed.isNotEmpty) {
        _followed.addAll(followed);
        emitter(NotificationLoadedState(followed: followed));
      }
    } on APIRequestException catch (ex) {
      logError("API Error occured while initializing notifications vm",
          error: Exception(ex));
      emitter(NotificationErrorState(state, ErrorType.noInternet));
    } catch (e) {
      logError("Error occured while initializing notifications vm",
          error: Exception(e));
      emitter(NotificationErrorState(state, ErrorType.unknownError));
    } finally {
      emitter(NotificationLoadedState(followed: _followed).copyWith(
          isBusy: false,
          followed: _followed,
          isNotifEmpty: _followed.isNotEmpty));
    }
  }

  Future<void> _done(
      NotificationDoneEvent event, Emitter<NotificationState> emitter) async {
    try {
      emitter(NotificationLoadedState(isBusy: true));
      if (event.options == NotificationOption.authorsOption) {
        await _unFollowAuthorsUseCase(_toUnFollow.map((e) => e.id!).toList());
      } else if (event.options == NotificationOption.editorsOption) {
        await _unFollowEditorsUseCase(_toUnFollow.map((e) => e.id!).toList());
      } else if (event.options == NotificationOption.themesOption) {
        final List<(int, int)> values = [];
        for (final item in _toUnFollow) {
          final subThemeItem = item as SubThemeFollowItemWithCategoryEntity;
          values.add((subThemeItem.id ?? 0, subThemeItem.categoryId ?? 0));
        }
        await _unFollowThemesUseCase(values);
      }
      //. call emittter
    } on APIRequestException catch (ex) {
      logError("API Error occured while exiting notifications vm",
          error: Exception(ex));
      emitter(NotificationErrorState(state, ErrorType.serverError));
    } catch (e) {
      logError("Error occured while exiting notifications vm",
          error: Exception(e));
      emitter(NotificationErrorState(state, ErrorType.unknownError));
    } finally {
      emitter(NotificationLoadedState().copyWith(followed: _followed));
    }
  }

  void notificationChecked(FollowItemEntity followItem) {
    if (_toUnFollow.contains(followItem)) {
      _toUnFollow.remove(followItem);
    } else {
      _toUnFollow.add(followItem);
    }
  }

  void _displayedModal(
      DisplayedModalEvent event, Emitter<NotificationState> emitter) {
    if (state is NotificationErrorState) {
      emitter((state as NotificationErrorState).previousState);
    }
  }
}

enum NotificationOption { authorsOption, editorsOption, themesOption }
