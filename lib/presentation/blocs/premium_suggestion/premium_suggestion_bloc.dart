import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/use_cases/products/get_premium_products_suggestions_use_case.dart';
import 'package:youscribe/core/use_cases/products/use_token_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_available_token_use_case.dart';
import 'package:youscribe/core/use_cases/user/load_user_account_use_case.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'premium_suggestion_event.dart';
part 'premium_suggestion_state.dart';

class PremiumSuggestionBloc
    extends Bloc<PremiumSuggestionEvent, PremiumSuggestionState>
    with Debuggable, Loggable {
  PremiumSuggestionBloc() : super(PremiumSuggestionStateInitial()) {
    on<InitPremiumSuggestionEvent>(_init);
    on<ErrorDisplayedEvent>(_errorDisplayed);
  }
  late final ConnectivityService _connectivityService = locator();
  late final LoadUserAccounttUseCase _loadUserAccounttUseCase = locator();
  late final GetAvailableTokensUseCase _getAvailableTokensUseCase = locator();
  late final GetPremiumProductsSuggestionsUseCase
      _getPremiumProductsSuggestionsUseCase = locator();
  late final UseTokenUseCase _useTokenUseCase = locator();
  bool _hasTokenSubscription = false;
  bool _hasAvailableToken = false;
  final List<ProductEntity> _products = [];
  bool _isLoading = false;

  @override
  String get debugName => 'PremiumSuggestionBloc';

  Future<void> _init(InitPremiumSuggestionEvent event,
      Emitter<PremiumSuggestionState> emitter) async {
    try {
      if (!await _connectivityService.isInternetAvailable) {
        emitter(PremiumSuggestionErrorState(state, ErrorType.noInternet));
        return;
      }
      _isLoading = true;
      emitter(PremiumSuggestionStateLoading().copyWith(isLoading: _isLoading));
      logInfo("Loading user profil from API, to get Premium info.");
      final loadUser = await _loadUserAccounttUseCase(null);
      final currentUser = await AuthenticationManager.getCurrentUser();

      final profil = loadUser.ok;
      _hasTokenSubscription =
          profil!.premiumIsAllowed && currentUser!.isSubscriber!;
      logInfo("User has premium subscription: ${profil.premiumIsAllowed}");
      logInfo("Getting available tokens count.");
      final loadTokens = await _getAvailableTokensUseCase(currentUser?.id);
      final tokens = loadTokens.ok!;
      final availableTokensCount = tokens.tokens.length;
      _hasAvailableToken = availableTokensCount > 0;
      logInfo("Available tokens count $availableTokensCount");
      logInfo("Loading premium suggestions.");
      final laodSug = await _getPremiumProductsSuggestionsUseCase(
          GetPremiumProductsSuggestionsUseCaseParameters(event.productId, 20));
      final suggestions = laodSug.ok;

      for (var i = 0; i < suggestions!.length; i++) {
        final product = suggestions[i];
        if (product.id != event.productId) {
          _products.add(product);
        }
      }
      emitter(PremiumSuggestionStateLoading(
          hasTokenSubscription: _hasTokenSubscription,
          hasAvailableToken: _hasAvailableToken,
          products: _products));
    } on APIRequestException catch (ex) {
      logError("Error while initializing premium suggestions popup",
          error: Exception(ex));
      emitter(PremiumSuggestionErrorState(state, ErrorType.serverError));
    } catch (e) {
      logError("Error while initializing premium suggestions popup",
          error: Exception(e));
      emitter(PremiumSuggestionErrorState(state, ErrorType.unknownError));
    } finally {
      _isLoading = false;
    }
  }

  Future<PremiumSuggestionsResult> useToken(int productId) async {
    try {
      _isLoading = true;
      if (_hasTokenSubscription && !_hasAvailableToken) {
        logInfo(
            "We ask the caller to navigate to help route for the user, since he has a subscription, but no token is available.");

        return PremiumSuggestionsResult.shouldNavigateToHelp;
      }
      if (await _connectivityService.isInternetAvailable) {
        if (!_hasTokenSubscription) {
          logInfo(
              "We navigate to the subscription popup for the user, since he has no subscription.");
          return PremiumSuggestionsResult.shouldSubscribe;
        }
        final currentUser = await AuthenticationManager.getCurrentUser();
        logInfo("Purchasing the book with a token.");
        final useToken = await _useTokenUseCase(
            UseTokenUseCaseParameters(currentUser!.id!, productId));

        logInfo("Was purchase sussecful ? $useToken.ok!");
        return PremiumSuggestionsResult.hasUsedToken;
      } else {
        logInfo("No internet connection, we can't purchase the book.");
        emit(PremiumSuggestionErrorState(state, ErrorType.noInternet));
        return PremiumSuggestionsResult.noInternet;
      }
    } on APIRequestException catch (ex) {
      logError(
          "An error occured while purchasing token subscription for book: $productId",
          error: Exception(ex));
      return PremiumSuggestionsResult.errorServer;
    } catch (e) {
      logError(
          "An error occured while purchasing token subscription for book: $productId",
          error: Exception(e));
      return PremiumSuggestionsResult.errorUnknown;
    }
  }

  void _errorDisplayed(
      ErrorDisplayedEvent event, Emitter<PremiumSuggestionState> emitter) {
    if (state is PremiumSuggestionErrorState) {
      emitter((state as PremiumSuggestionErrorState).previousState);
    }
  }
}

enum PremiumSuggestionsResult {
  shouldNavigateToHelp,
  shouldSubscribe,
  hasUsedToken,
  noResult,
  noInternet,
  errorServer,
  errorUnknown,
}
