import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/light_account_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/use_cases/search/get_author_products_use_case.dart';
import 'package:youscribe/core/use_cases/user/follow_author_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_followers_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_owner_account_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_author_use_case.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState>
    with Debuggable, Loggable {
  AuthorBloc() : super(AuthorInitialState()) {
    on<InitAuthorEvent>(_init);
    on<LoadNewPageEvent>(_loadPage);
    on<FollowEvent>(_follow);

    on<ErrorDisplayedEvent>(_errorDisplayed);

    _connectivityService = locator<ConnectivityService>();
    _getAuthorProductsUseCase = locator<GetAuthorProductsUseCase>();
    _getOwnerAccountUseCase = locator<GetOwnerAccountUseCase>();
    _getFollowersByProductUseCase = locator<GetFollowersByProductUseCase>();
    _unFollowAuthorUseCase = locator<UnFollowAuthorUseCase>();
    _followAuthorUseCase = locator<FollowAuthorUseCase>();
  }

  late final ConnectivityService _connectivityService;
  List<ProductEntity> _products = [];
  bool _isFollowing = false;
  bool _hasNext = false;

  String language = "";
  int publisherId = 0;
  int pageSize = 10;

  late final GetAuthorProductsUseCase _getAuthorProductsUseCase;
  late final GetOwnerAccountUseCase _getOwnerAccountUseCase;
  late final GetFollowersByProductUseCase _getFollowersByProductUseCase;
  late final UnFollowAuthorUseCase _unFollowAuthorUseCase;
  late final FollowAuthorUseCase _followAuthorUseCase;

  @override
  String get debugName => 'AuthorBloc';

  Future<void> _init(
      InitAuthorEvent event, Emitter<AuthorState> emitter) async {
    publisherId = event.authorId;
    language = event.language;
    try {
      LightAccountEntity? publishingUser;
      if (!await _connectivityService.isInternetAvailable) {
        emitter(AuthorErrorState(state, ErrorType.noInternet));
        return;
      }
      final publishingUserResult = await _getOwnerAccountUseCase(publisherId);
      publishingUser = publishingUserResult.ok;
      final results = await _loadNewProductPages();
      _isFollowing = publishingUser?.isFollowed ?? false;
      _hasNext = results.$2;
      if (results.$1.isNotEmpty) {
        results.$1.forEach(_products.add);
        final followed =
            await _getFollowersByProductUseCase(_products.first.id);
        _isFollowing = followed.ok?.isAuthorFollowed ?? false;
      }
      emitter(AuthorStateLoadedState(
          products: _products,
          isFollowing: _isFollowing,
          displayName: event.displayName));
    } on APIRequestException catch (ex) {
      logError("API Error occured while initializing publisher details vm",
          error: Exception(ex));
      emitter(AuthorErrorState(state, ErrorType.serverError));
    } catch (e) {
      logError("Error occured while initializing product vm",
          error: Exception(e));
      emitter(AuthorErrorState(state, ErrorType.unknownError));
    }
  }

  void _errorDisplayed(
      ErrorDisplayedEvent event, Emitter<AuthorState> emitter) {
    if (state is AuthorErrorState) {
      emitter((state as AuthorErrorState).previousState);
    }
  }

  Future<void> _follow(FollowEvent event, Emitter<AuthorState> emitter) async {
    if (!await _connectivityService.isInternetAvailable) {
      emitter(AuthorErrorState(state, ErrorType.noInternet));
      return;
    }

    try {
      emitter(
          AuthorStateLoadedState(products: _products).copyWith(isBusy: true));

      if (_isFollowing) {
        await _unFollowAuthorUseCase(publisherId);
      } else {
        await _followAuthorUseCase(publisherId);
      }
      _isFollowing = !_isFollowing;
    } catch (e) {
      logError("Following : $_isFollowing editor failed.", error: Exception(e));
    } finally {
      emitter(AuthorStateLoadedState(products: _products)
          .copyWith(isBusy: false, isFollowing: _isFollowing));
    }
  }

  Future<void> _loadPage(
      LoadNewPageEvent event, Emitter<AuthorState> emitter) async {
    try {
      if (!_hasNext) {
        final results = await _loadNewProductPages();
        _products = [..._products, ...results.$1];
        _hasNext = results.$2;
        emitter(AuthorStateLoadedState(
            products: _products, isFollowing: _isFollowing));
      }
    } catch (e) {
      logError("""
Unknown Error occured while performing infinitescroll for Products List""",
          error: Exception(e));
    }
  }

  Future<(List<ProductEntity>, bool)> _loadNewProductPages() async {
    final GetAuthorProductsUseCaseParameters params =
        GetAuthorProductsUseCaseParameters(
            publisherId, pageSize, _products.length, language);
    final searchResult = await _getAuthorProductsUseCase(params);
    if (searchResult.isErr) {
      logError('Error getting authors products  ${searchResult.err!.message}',
          error: searchResult.err);
      return (<ProductEntity>[], false);
    }
    return (
      searchResult.ok!.products ?? [],
      searchResult.ok!.products!.length >
          (_products.length + searchResult.ok!.products!.length)
    );
  }
}
