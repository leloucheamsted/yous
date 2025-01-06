import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_it/get_it.dart';
import 'package:youscribe/core/use_cases/authentication/forgot_passsword_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/loading_init_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/login_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/login_with_apple_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/login_with_canalplus.dart';
import 'package:youscribe/core/use_cases/authentication/login_with_facebook.dart';
import 'package:youscribe/core/use_cases/authentication/login_with_gar_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/logout_from_gar_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/logout_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/on_authentication_status_change_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/sign_up_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/startup_authentication_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/user_setup_use_case.dart';
import 'package:youscribe/core/use_cases/configurations/get_country_configuration_use_case.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/core/use_cases/configurations/send_init_data_usecase.dart';
import 'package:youscribe/core/use_cases/configurations/set_user_configurations_usecase.dart';
import 'package:youscribe/core/use_cases/configurations/set_user_country_config_use_case.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import 'package:youscribe/core/use_cases/downloads/get_document_password_use_case.dart';
import 'package:youscribe/core/use_cases/downloads/post_download_use_case.dart';
import 'package:youscribe/core/use_cases/home/get_home_use_case.dart';
import 'package:youscribe/core/use_cases/home/read_home_product_suggestions.dart';
import 'package:youscribe/core/use_cases/my_selections/add_product_to_selection_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/create_new_selection_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/delete_selection_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/get_my_selection_products_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/get_my_selection_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/remove_product_from_selection_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/update_selection_use_case.dart';
import 'package:youscribe/core/use_cases/products/add_product_to_favorites_usecase.dart';
import 'package:youscribe/core/use_cases/products/add_product_to_offlines_usecase.dart';
import 'package:youscribe/core/use_cases/products/check_product_access_rights_use_case.dart';
import 'package:youscribe/core/use_cases/products/delete_product_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_favorite_products_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_last_read_products_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_new_product_suggestions_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_offline_products_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_premium_products_suggestions_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_product_collections_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_product_progress.dart';
import 'package:youscribe/core/use_cases/products/get_product_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_products_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_ysselection_products_use_case.dart';
import 'package:youscribe/core/use_cases/products/init_audio_player_usecase.dart';
import 'package:youscribe/core/use_cases/products/product_read_use_case.dart';
import 'package:youscribe/core/use_cases/products/remove_from_favorites_usecase.dart';
import 'package:youscribe/core/use_cases/products/remove_from_offlines_usecase.dart';
import 'package:youscribe/core/use_cases/products/save_offline_product_use_case.dart';
import 'package:youscribe/core/use_cases/products/sync_book_mark_use_case.dart';
import 'package:youscribe/core/use_cases/products/sync_fav_products_usecase.dart';
import 'package:youscribe/core/use_cases/products/sync_last_read_products_usecase.dart';
import 'package:youscribe/core/use_cases/products/sync_offline_products_usecase.dart';
import 'package:youscribe/core/use_cases/products/unzip_epub_use_case.dart';
import 'package:youscribe/core/use_cases/products/unzip_mp3_use_case.dart';
import 'package:youscribe/core/use_cases/products/use_token_use_case.dart';
import 'package:youscribe/core/use_cases/reader/get_latest_bookmark_use_case.dart';
import 'package:youscribe/core/use_cases/reader/save_bookmark_use_case.dart';
import 'package:youscribe/core/use_cases/search/can_follow_search_theme_use_case.dart';
import 'package:youscribe/core/use_cases/search/follow_sub_theme_use_case.dart';
import 'package:youscribe/core/use_cases/search/get_author_products_use_case.dart';
import 'package:youscribe/core/use_cases/search/get_first_level_search_options_usecase.dart';
import 'package:youscribe/core/use_cases/search/get_n_level_search_options_use_case.dart';
import 'package:youscribe/core/use_cases/search/get_publisher_products_use_case.dart';
import 'package:youscribe/core/use_cases/search/get_search_suggestions_use_case.dart';
import 'package:youscribe/core/use_cases/search/search_product_usecase.dart';
import 'package:youscribe/core/use_cases/user/delete_account_use_case.dart';
import 'package:youscribe/core/use_cases/user/follow_author_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/follow_author_use_case.dart';
import 'package:youscribe/core/use_cases/user/follow_editor_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/follow_editor_use_case.dart';
import 'package:youscribe/core/use_cases/user/follow_sub_theme_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_authors_followed_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_available_token_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_date_for_next_token_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_editors_followed_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_expired_token_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_followers_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_owner_account_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_publisher_account_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_themes_followed_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_user_token_use_case.dart';
import 'package:youscribe/core/use_cases/user/is_user_subscribe_use_case.dart';
import 'package:youscribe/core/use_cases/user/load_user_account_use_case.dart';
import 'package:youscribe/core/use_cases/user/retreive_user_selections_use_case.dart';
import 'package:youscribe/core/use_cases/user/save_user_selections_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_author_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_author_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_authors_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_editor_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_editor_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_editors_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_sub_theme_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_themes_use_case.dart';

extension UseCaseLocatorHelper on GetIt {
  // Inject Usecases
  void registerUseCases() {
    this
      ..registerLazySingleton<GetDocumentPasswordUseCase>(
        () => GetDocumentPasswordUseCase(
          documentRepository: this(),
        ),
      )
      ..registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(
          authenticationRepository: this(),
        ),
      )
      ..registerLazySingleton<LoginWithFacebookUseCase>(
        () => LoginWithFacebookUseCase(
          authenticationRepository: this(),
        ),
      )
      ..registerLazySingleton<LoginWithAppleUseCase>(
        () => LoginWithAppleUseCase(
          authenticationRepository: this(),
        ),
      )
      ..registerLazySingleton<FlutterDownloader>(FlutterDownloader.new)
      ..registerLazySingleton<InitAudioPlayerUseCase>(
        InitAudioPlayerUseCase.new,
      )
      ..registerLazySingleton<GetFirstLevelSearchOptionsUseCase>(
        () => GetFirstLevelSearchOptionsUseCase(this(), this()),
      )
      ..registerLazySingleton<GetNLevelSearchOptionUseCase>(
        () => GetNLevelSearchOptionUseCase(this(), this()),
      )
      ..registerLazySingleton<GetFavoriteProductsUseCase>(
        () => GetFavoriteProductsUseCase(this(), this()),
      )
      ..registerLazySingleton<SetUserConfigurationsUseCase>(
        () => SetUserConfigurationsUseCase(this()),
      )
      ..registerLazySingleton<SendInitDataUseCase>(
        () => SendInitDataUseCase(this()),
      )
      ..registerLazySingleton<GetOfflineProductsUseCase>(
        () => GetOfflineProductsUseCase(this(), this()),
      )
      ..registerLazySingleton<GetNewProductSuggestionsUseCase>(
        () => GetNewProductSuggestionsUseCase(this()),
      )
      ..registerLazySingleton<CreateNewSelectionUseCase>(
        () => CreateNewSelectionUseCase(this()),
      )
      ..registerLazySingleton<GetAuthorsFollowedUseCase>(
        () => GetAuthorsFollowedUseCase(this()),
      )
      ..registerLazySingleton<GetEditorsFollowedUseCase>(
        () => GetEditorsFollowedUseCase(this()),
      )
      ..registerLazySingleton<GetThemesFollowedUseCase>(
        () => GetThemesFollowedUseCase(this()),
      )
      ..registerLazySingleton<UnFollowAuthorsUseCase>(
        () => UnFollowAuthorsUseCase(this()),
      )
      ..registerLazySingleton<UnFollowEditorsUseCase>(
        () => UnFollowEditorsUseCase(this()),
      )
      ..registerLazySingleton<UnFollowThemesUseCase>(
        () => UnFollowThemesUseCase(this()),
      )
      ..registerLazySingleton<GetProductCollectionsUseCase>(
        () => GetProductCollectionsUseCase(this()),
      )
      ..registerLazySingleton<GetFollowersByProductUseCase>(
        () => GetFollowersByProductUseCase(this()),
      )
      ..registerLazySingleton<GetPremiumProductsSuggestionsUseCase>(
          () => GetPremiumProductsSuggestionsUseCase(this()))
      ..registerLazySingleton<GetLastReadProductsUseCase>(
          () => GetLastReadProductsUseCase(this(), this()))
      ..registerLazySingleton<DeleteSelectionUseCase>(
        () => DeleteSelectionUseCase(this()),
      )
      ..registerLazySingleton<UpdateSelectionUseCase>(
        () => UpdateSelectionUseCase(this()),
      )
      ..registerLazySingleton<UseTokenUseCase>(
        () => UseTokenUseCase(this()),
      )
      ..registerLazySingleton<AddProductToSelectionUseCase>(
        () => AddProductToSelectionUseCase(this()),
      )
      ..registerLazySingleton<GetMySelectionProductsUseCase>(
        () => GetMySelectionProductsUseCase(this()),
      )
      ..registerLazySingleton<RemoveProductFromSelectionUseCase>(
        () => RemoveProductFromSelectionUseCase(this()),
      )
      ..registerLazySingleton<DeleteAccountUseCase>(
        () => DeleteAccountUseCase(this()),
      )
      ..registerLazySingleton<SetUserCountryConfigUseCase>(
        () => SetUserCountryConfigUseCase(this()),
      )
      ..registerLazySingleton<UserSetupUseCase>(
        UserSetupUseCase.new,
      )
      ..registerLazySingleton<LoadUserAccounttUseCase>(
          () => LoadUserAccounttUseCase(this()))
      ..registerLazySingleton<GetUserTokenUseCase>(
          () => GetUserTokenUseCase(this()))
      ..registerLazySingleton<GetExpiredTokenUseCase>(
          () => GetExpiredTokenUseCase(this()))
      ..registerLazySingleton<GetDateForNextTokenUseCase>(
          () => GetDateForNextTokenUseCase(this()))
      ..registerLazySingleton<GetProductsUseCase>(
          () => GetProductsUseCase(this()))
      ..registerLazySingleton<GetAvailableTokensUseCase>(
          () => GetAvailableTokensUseCase(this()))
      ..registerLazySingleton<GetMySelectionsUseCase>(
        () => GetMySelectionsUseCase(this()),
      )
      ..registerLazySingleton<GetHomeUseCase>(
        () => GetHomeUseCase(this()),
      )
      ..registerLazySingleton<ReadHomeProductSuggestionsUseCase>(
        () => ReadHomeProductSuggestionsUseCase(this()),
      )
      ..registerLazySingleton<RemoveFromOfflinesUseCase>(
        RemoveFromOfflinesUseCase.new,
      )
      ..registerLazySingleton<AddProductToOfflinesUseCase>(
        AddProductToOfflinesUseCase.new,
      )
      ..registerLazySingleton<AddProductToFavoritesUseCase>(
        AddProductToFavoritesUseCase.new,
      )
      ..registerLazySingleton<RemoveFromFavoritesUseCase>(
        RemoveFromFavoritesUseCase.new,
      )
      ..registerLazySingleton<FollowSubthemeUseCase>(
        FollowSubthemeUseCase.new,
      )
      ..registerLazySingleton<SearchUseCase>(
        SearchUseCase.new,
      )
      ..registerLazySingleton<GetBookmarkUseCase>(
        GetBookmarkUseCase.new,
      )
      ..registerLazySingleton<SaveBookmarkUseCase>(
        SaveBookmarkUseCase.new,
      )
      ..registerLazySingleton<ProductReadUseCase>(
        ProductReadUseCase.new,
      )
      ..registerLazySingleton<SyncBookMarkUsecase>(SyncBookMarkUsecase.new)
      ..registerLazySingleton<SyncFavoriteProductsUsecase>(
          SyncFavoriteProductsUsecase.new)
      ..registerLazySingleton<SyncOfflineProductsUsecase>(
          SyncOfflineProductsUsecase.new)
      ..registerLazySingleton<SyncLastReadProductsUsecase>(
          SyncLastReadProductsUsecase.new)
      ..registerLazySingleton<CanFollowSearchThemeUseCase>(
        CanFollowSearchThemeUseCase.new,
      )
      ..registerLazySingleton<GetSearchSuggestionsUseCase>(
        () => GetSearchSuggestionsUseCase(this()),
      )
      ..registerLazySingleton<DownloadProductUseCase>(
        () => DownloadProductUseCase(this(), this(), this(), this()),
      )
      ..registerLazySingleton<CheckProductAccessRightsUseCase>(
        () => CheckProductAccessRightsUseCase(this(), this(), this(), this()),
      )
      ..registerLazySingleton<LogoutUseCase>(
        () => LogoutUseCase(authenticationRepository: this()),
      )
      ..registerLazySingleton<IsUserSubscribeUseCase>(
        () => IsUserSubscribeUseCase(this()),
      )
      ..registerLazySingleton(
        () => SignUpUseCase(authenticationRepository: this()),
      )
      ..registerLazySingleton(
        () => DeleteProductUseCase(this()),
      )
      ..registerLazySingleton(
        () => FollowAuthorByProductUseCase(this()),
      )
      ..registerLazySingleton(
        () => FollowEditorByProductUseCase(this()),
      )
      ..registerLazySingleton(
        () => FollowSubThemeByProductUseCase(this()),
      )
      ..registerLazySingleton(
        () => UnFollowEditorByProductUseCase(this()),
      )
      ..registerLazySingleton(
        () => RetreiveUserSelectionsUseCase(this()),
      )
      ..registerLazySingleton(
        () => SaveUserSelectionsUseCase(this()),
      )
      ..registerLazySingleton(
        () => GetCountryConfigurationUseCase(this()),
      )
      ..registerLazySingleton(
        () => UnFollowAuthorByProductUseCase(this()),
      )
      ..registerLazySingleton(
        () => UnFollowAuthorUseCase(this()),
      )
      ..registerLazySingleton(
        () => UnFollowEditorUseCase(this()),
      )
      ..registerLazySingleton(
        () => FollowAuthorUseCase(this()),
      )
      ..registerLazySingleton(
        () => FollowEditorUseCase(this()),
      )
      ..registerLazySingleton(
        () => GetProductUseCase(this()),
      )
      ..registerLazySingleton(
        () => SaveOfflineProductUseCase(this()),
      )
      ..registerLazySingleton(
        () => UnFollowSubThemeByProductUseCase(this()),
      )
      ..registerLazySingleton(
        () => GetOwnerAccountUseCase(this()),
      )
      ..registerLazySingleton(
        () => GetPublisherAccountUseCase(this()),
      )
      ..registerLazySingleton(
        () => GetAuthorProductsUseCase(this()),
      )
      ..registerLazySingleton(
        () => GetPublisherProductsUseCase(this()),
      )
      ..registerLazySingleton(
        () => StartupAuthenticationUseCase(this()),
      )
      ..registerLazySingleton(
        () => GetUserSettingsUseCase(this()),
      )
      ..registerLazySingleton(
        () => GetYsSelectionProductsUseCase(this()),
      )
      ..registerLazySingleton(
        () => ForgotPasswordUseCase(authenticationRepository: this()),
      )
      ..registerLazySingleton(LoginWithCanalPlusUseCase.new)
      ..registerLazySingleton(() => LoginWithGARUseCase(this()))
      ..registerLazySingleton(() => LogoutFromGARUseCase(this()))
      ..registerLazySingleton(LoadingInitUseCase.new)
      ..registerLazySingleton(OnAuthenticationStatusChangeUseCase.new)
      ..registerLazySingleton<UnzipEpubUseCase>(
        UnzipEpubUseCase.new,
      )
      ..registerLazySingleton<UnzipMp3UseCase>(
        UnzipMp3UseCase.new,
      )
      ..registerLazySingleton<PostDownloadUseCase>(
        () => PostDownloadUseCase(
          unzipEpubUseCase: this(),
          unzipMp3UseCase: this(),
        ),
      )
      ..registerLazySingleton<GetProductProgress>(
        () => GetProductProgress(
          documentRepository: this(),
        ),
      );
  }
}
