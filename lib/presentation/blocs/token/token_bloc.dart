import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/token_product_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/use_cases/products/get_products_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_available_token_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_date_for_next_token_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_user_token_use_case.dart';
import 'package:youscribe/core/use_cases/user/load_user_account_use_case.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> with Debuggable, Loggable {
  TokenBloc() : super(TokenInitialState()) {
    on<InitTokenEvent>(_init);
    on<ErrorDisplayedEvent>(_errorDisplayed);
  }
  late final ConnectivityService _connectivityService = locator();
  late final LoadUserAccounttUseCase _loadUserAccounttUseCase = locator();
  late final GetDateForNextTokenUseCase _getDateForNextTokenUseCase = locator();
  late final GetUserTokenUseCase _getUserTokenUseCase = locator();
  late final GetAvailableTokensUseCase _getAvailableTokensUseCase = locator();
  late final GetProductsUseCase _getProductsUseCase = locator();
  bool _hasTokenSubscription = false;
  int _availableTokensCount = 0;
  List<TokenProductEntity> tokenProducts = [];
  int _usedTokensCount = 0;
  bool _hasUsedTokens = false;
  bool _hasNextToken = false;
  bool _hasAvailableToken = false;
  final bool _hasToken = false;
  DateTime? _nextTokenDate;

  @override
  String get debugName => 'TokenBloc';

  Future<void> _init(InitTokenEvent event, Emitter<TokenState> emitter) async {
    try {
      if (!await _connectivityService.isInternetAvailable) {
        logInfo('Internet is not available, displaying error message.');
        emitter(TokenErrorState(state, errorType: ErrorType.noInternet));
        return;
      }
      await loadToken();
      emitter(TokenLoadedState(
          hasAvailableToken: _hasAvailableToken,
          availableTokensCount: _availableTokensCount,
          tokenProducts: tokenProducts,
          usedTokensCount: _usedTokensCount,
          nextTokenDate: _nextTokenDate,
          hasUsedTokens: _hasUsedTokens,
          hasTokenSubscription: _hasTokenSubscription,
          hasNextToken: _hasNextToken,
          hasToken: _hasToken));
    } on APIRequestException catch (e) {
      logError('API error occurred while initializing premium token vm',
          error: Exception(e));

      if (!await handleUnauthorizedAPIErrors(e)) {
        emitter(TokenErrorState(state as TokenLoadedState,
            errorType: ErrorType.serverError));
      }
    } catch (e) {
      logError('Unknown error occurred while initializing premium token vm',
          error: Exception(e));
      emitter(TokenErrorState(state as TokenLoadedState,
          errorType: ErrorType.unknownError));
    }
  }

  Future<bool> handleUnauthorizedAPIErrors(
      APIRequestException exception) async {
    logWarning(
        // ignore: lines_longer_than_80_chars
        "Unauthorized request sent in an unexpected fashion, so, we log out the user.");
    if (exception.statusCode == 401 || exception.statusCode == 403) {
      logWarning("User logged out");
      return true;
    }

    logWarning("Status code wasn't unauthorized. Instead it was: {0}",
        error: exception);
    return false;
  }

  Future<void> _errorDisplayed(
      ErrorDisplayedEvent event, Emitter<TokenState> emitter) async {
    if (state is TokenErrorState) {
      emitter((state as TokenErrorState).previousState);
    }
  }

  Future<void> refresh() async {
    await loadToken();
    emit(TokenLoadedState(
        hasAvailableToken: _hasAvailableToken,
        availableTokensCount: _availableTokensCount,
        tokenProducts: tokenProducts,
        usedTokensCount: _usedTokensCount,
        nextTokenDate: _nextTokenDate,
        hasUsedTokens: _hasUsedTokens,
        hasTokenSubscription: _hasTokenSubscription,
        hasNextToken: _hasNextToken,
        hasToken: _hasToken));
  }

  Future<void> loadToken() async {
    final currentUser = await AuthenticationManager.getCurrentUser();
    logInfo('Loading user profile.');
    final userProfile = await _loadUserAccounttUseCase(null);
    final prefs = await SharedPreferences.getInstance();
    final isGarUserConnected = prefs.getBool(PreferenceKey.isGarUserConnected);

    _hasTokenSubscription =
        userProfile.ok!.premiumIsAllowed && currentUser!.isSubscriber!;
    if (isGarUserConnected != null && isGarUserConnected) {
      _hasTokenSubscription = isGarUserConnected;
    }
    logInfo('User has token subscription: $_hasTokenSubscription');
    logInfo('Getting date for the next token');
    final getDateForNextTokenResult =
        await _getDateForNextTokenUseCase(currentUser!.id);
    _nextTokenDate = getDateForNextTokenResult.ok;
    _hasNextToken = _nextTokenDate.isNotNull;
    logInfo('Getting used tokens.');
    final usedTokens = await _getUserTokenUseCase(currentUser.id);
    logInfo('Getting available tokens.');
    final availableTokens = await _getAvailableTokensUseCase(currentUser.id);
    _availableTokensCount = availableTokens.ok!.tokens.length;
    _hasAvailableToken = _availableTokensCount > 0;
    if (usedTokens.ok.isNotNull && usedTokens.ok!.tokens.isNotEmpty) {
      _usedTokensCount = usedTokens.ok?.tokens.length ?? 0;
      final productIdsAndDateUsed = usedTokens.ok?.tokens
          .map((token) => (token.productId, token.usedDate));
      final productIds =
          usedTokens.ok?.tokens.map((token) => token.productId ?? 0).toList();
      final productsUsedForTokens = await _getProductsUseCase(productIds);
      _hasUsedTokens = productsUsedForTokens.ok?.isNotEmpty ?? false;
      if (_hasUsedTokens) {
        tokenProducts = productsUsedForTokens.ok!.map((prod) {
          final pidDate = productIdsAndDateUsed!
              .firstWhere((pidDate) => pidDate.$1 == prod.id);
          return TokenProductEntity()
            ..product = prod
            ..dateUsed = pidDate.$2;
        }).toList();
      }
    } else if (tokenProducts.isNotEmpty) {
      tokenProducts.clear();
    }
  }
}
