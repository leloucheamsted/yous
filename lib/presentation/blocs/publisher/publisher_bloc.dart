import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/light_account_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/use_cases/search/get_publisher_products_use_case.dart';
import 'package:youscribe/core/use_cases/user/follow_editor_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_followers_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_publisher_account_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_editor_use_case.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'publisher_event.dart';
part 'publisher_state.dart';

class PublisherBloc extends Bloc<PublisherEvent, PublisherState>
    with Debuggable, Loggable {
  PublisherBloc() : super(PublisherInitialState()) {
    on<InitPublisherEvent>(_init);
    on<LoadNewPageEvent>(_loadPage);
    on<FollowEvent>(_follow);

    on<ErrorDisplayedEvent>(_errorDisplayed);
    _connectivityService = locator<ConnectivityService>();
    _getPublisherProductsUseCase = locator<GetPublisherProductsUseCase>();
    _getPublisherAccountUseCase = locator<GetPublisherAccountUseCase>();
    _getFollowersByProductUseCase = locator<GetFollowersByProductUseCase>();
    _unFollowEditorUseCase = locator<UnFollowEditorUseCase>();
    _followEditorUseCase = locator<FollowEditorUseCase>();
  }

  late final ConnectivityService _connectivityService;
  List<ProductEntity> _products = [];
  bool _isFollowing = false;
  bool _hasNext = false;
  String language = "";
  String _image = "";
  String _biography = "";
  int publisherId = 0;
  int pageSize = 10;

  late final GetPublisherProductsUseCase _getPublisherProductsUseCase;
  late final GetPublisherAccountUseCase _getPublisherAccountUseCase;
  late final GetFollowersByProductUseCase _getFollowersByProductUseCase;
  late final FollowEditorUseCase _followEditorUseCase;
  late final UnFollowEditorUseCase _unFollowEditorUseCase;

  @override
  String get debugName => 'PublisherBloc';

  Future<void> _init(
      InitPublisherEvent event, Emitter<PublisherState> emitter) async {
    publisherId = event.publisherId;
    language = event.language;
    try {
      LightAccountEntity? publishingUser;
      if (!await _connectivityService.isInternetAvailable) {
        emitter(PublisherErrorState(state, ErrorType.noInternet));
        return;
      }
      final publishingUserResult =
          await _getPublisherAccountUseCase(publisherId);
      publishingUser = publishingUserResult.ok;
      final results = await _loadNewProductPages();
      _isFollowing = publishingUser?.isFollowed ?? false;
      _hasNext = results.$2;
      _image = "https:${publishingUser?.avatarUrls?.first}";
      _biography = publishingUser?.biography ?? "";
      if (results.$1.isNotEmpty) {
        results.$1.forEach(_products.add);
        final followed =
            await _getFollowersByProductUseCase(_products.first.id);
        _isFollowing = followed.ok?.isEditorFollowed ?? false;
      }
      emitter(PublisherStateLoadedState(
          products: _products,
          isFollowing: _isFollowing,
          image: _image,
          biography: _biography,
          displayName: event.displayName));
    } on APIRequestException catch (ex) {
      logError("API Error occured while initializing publisher details vm",
          error: Exception(ex));
      emitter(PublisherErrorState(state, ErrorType.serverError));
    } catch (e) {
      logError("Error occured while initializing product vm",
          error: Exception(e));
      emitter(PublisherErrorState(state, ErrorType.unknownError));
    }
  }

  Future<(List<ProductEntity>, bool)> _loadNewProductPages() async {
    final GetPublisherProductsUseCaseParameters params =
        GetPublisherProductsUseCaseParameters(
            publisherId, pageSize, _products.length, language);
    final searchResult = await _getPublisherProductsUseCase(params);
    if (searchResult.isErr) {
      logError(
          'Error getting Publishers products  ${searchResult.err!.message}',
          error: searchResult.err);
      return (<ProductEntity>[], false);
    }
    return (
      searchResult.ok!.products ?? [],
      searchResult.ok!.products!.length >
          (_products.length + searchResult.ok!.products!.length)
    );
  }

  void _errorDisplayed(
      ErrorDisplayedEvent event, Emitter<PublisherState> emitter) {
    if (state is PublisherErrorState) {
      emitter((state as PublisherErrorState).previousState);
    }
  }

  Future<void> _follow(
      FollowEvent event, Emitter<PublisherState> emitter) async {
    if (!await _connectivityService.isInternetAvailable) {
      emitter(PublisherErrorState(state, ErrorType.noInternet));
      return;
    }

    try {
      emitter(PublisherStateLoadedState(products: _products)
          .copyWith(isBusy: true));

      if (_isFollowing) {
        await _unFollowEditorUseCase(publisherId);
      } else {
        await _followEditorUseCase(publisherId);
      }
      _isFollowing = !_isFollowing;
    } catch (e) {
      logError("Following : $_isFollowing editor failed.", error: Exception(e));
    } finally {
      emitter(PublisherStateLoadedState(products: _products)
          .copyWith(isBusy: false, isFollowing: _isFollowing));
    }
  }

  Future<void> _loadPage(
      LoadNewPageEvent event, Emitter<PublisherState> emitter) async {
    try {
      if (!_hasNext) {
        final results = await _loadNewProductPages();
        _products = [..._products, ...results.$1];
        _hasNext = results.$2;
        emitter(PublisherStateLoadedState(products: _products).copyWith(
            isFollowing: _isFollowing, image: _image, biography: _biography));
      }
    } catch (e) {
      logError(
          "Unknown Error occured while performing infinitescroll for Products List",
          error: Exception(e));
    }
  }
}
