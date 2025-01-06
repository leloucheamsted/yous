import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/audio_chapter_entity.dart';
import 'package:youscribe/core/entities/bookmark_entity.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/entities/home_entity.dart';
import 'package:youscribe/core/entities/product_document_password_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/reading_stats_entity.dart';
import 'package:youscribe/core/entities/user_global_settings_entity.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';
import 'package:youscribe/core/repositories/authentication_repository.dart';
import 'package:youscribe/core/repositories/bookmark_repository.dart';
import 'package:youscribe/core/repositories/country_config_repository.dart';
import 'package:youscribe/core/repositories/country_repository.dart';
import 'package:youscribe/core/repositories/device_repository.dart';
import 'package:youscribe/core/repositories/document_repository.dart';
import 'package:youscribe/core/repositories/home_repository.dart';
import 'package:youscribe/core/repositories/my_selection_repository.dart';
import 'package:youscribe/core/repositories/product_search_repository.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/data/data_sources/authentication_data_sources/authentication_remote_data_source.dart';
import 'package:youscribe/data/data_sources/authentication_data_sources/impls/authentication_remote_data_source_impl.dart';
import 'package:youscribe/data/data_sources/book_mark_data_sources/book_mark_remote_data_source_impl.dart';
import 'package:youscribe/data/data_sources/bookmark_data_sources/bookmark_local_data_source.dart';
import 'package:youscribe/data/data_sources/bookmark_data_sources/bookmark_remote_data_source.dart';
import 'package:youscribe/data/data_sources/bookmark_data_sources/impls/bookmark_local_data_source_impl.dart';
import 'package:youscribe/data/data_sources/country_config_data_sources/country_config_remote_data_source.dart';
import 'package:youscribe/data/data_sources/country_config_data_sources/impls/country_config_remote_data_source_impl.dart';
import 'package:youscribe/data/data_sources/device_data_sources/device_remote_data_source.dart';
import 'package:youscribe/data/data_sources/device_data_sources/impls/device_remote_data_souce_impl.dart';
import 'package:youscribe/data/data_sources/document_data_sources/document_local_data_source.dart';
import 'package:youscribe/data/data_sources/document_data_sources/document_remote_data_source.dart';
import 'package:youscribe/data/data_sources/document_data_sources/impls/document_local_data_source_impl.dart';
import 'package:youscribe/data/data_sources/document_data_sources/impls/document_remote_data_source_impl.dart';
import 'package:youscribe/data/data_sources/document_data_sources/impls/product_download_progress_local_data_source_impl.dart';
import 'package:youscribe/data/data_sources/document_data_sources/product_download_progress_local_data_source.dart';
import 'package:youscribe/data/data_sources/home_data_sources/home_local_data_source.dart';
import 'package:youscribe/data/data_sources/home_data_sources/home_remote_data_source.dart';
import 'package:youscribe/data/data_sources/home_data_sources/impls/home_local_data_source_impl.dart';
import 'package:youscribe/data/data_sources/home_data_sources/impls/home_remote_data_source_impl.dart';
import 'package:youscribe/data/data_sources/in_app_subscription_request_data_sources/impls/in_app_subscription_request_data_source_impl.dart';
import 'package:youscribe/data/data_sources/in_app_subscription_request_data_sources/in_app_subscription_request_data_source.dart';
import 'package:youscribe/data/data_sources/my_selection_data_sources/impls/my_selection_remote_data_source_impl.dart';
import 'package:youscribe/data/data_sources/my_selection_data_sources/my_selection_remote_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/impls/product_chapters_local_data_source_impl.dart';
import 'package:youscribe/data/data_sources/product_data_sources/impls/product_local_data_source_impl.dart';
import 'package:youscribe/data/data_sources/product_data_sources/impls/product_remote_data_source_impl.dart';
import 'package:youscribe/data/data_sources/product_data_sources/impls/reading_stat_local_data_source_impl.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_chapters_local_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_local_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_remote_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/reading_stat_local_data_source.dart';
import 'package:youscribe/data/data_sources/product_search_data_source/impls/product_search_remote_data_source_impl.dart';
import 'package:youscribe/data/data_sources/product_search_data_source/product_search_remote_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/account_premium_token_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/impls/account_premium_token_data_source_impl.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/impls/user_account_local_data_source_impl.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/impls/user_account_remote_data_source_impl.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/impls/user_settings_local_data_source_impl.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_account_local_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_account_remote_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_settings_local_data_source.dart';
import 'package:youscribe/data/repositories/authentication_repository_impl.dart';
import 'package:youscribe/data/repositories/bookmark_repository_impl.dart';
import 'package:youscribe/data/repositories/country_config_repository_impl.dart';
import 'package:youscribe/data/repositories/country_repository_impl.dart';
import 'package:youscribe/data/repositories/device_repository_impl.dart';
import 'package:youscribe/data/repositories/document_repository_impl.dart';
import 'package:youscribe/data/repositories/home_repository_impl.dart';
import 'package:youscribe/data/repositories/my_selection_repository_impl.dart';
import 'package:youscribe/data/repositories/product_repository_impl.dart';
import 'package:youscribe/data/repositories/product_search_repository_impl.dart';
import 'package:youscribe/data/repositories/user_accout_repository_impl.dart';

extension DataLocatorHelper on GetIt {
  void registerRepositories() {
    this
      ..registerLazySingleton<AuthenticationRepository>(() =>
          AuthenticationRepositoryImpl(
              authenticationRemoteDataSource: this(),
              authenticationLocalDataSource: this()))
      ..registerLazySingleton<DocumentRepository>(
        () => DocumentRepositoryImpl(
          documentLocalDataSource: this(),
          documentRemoteDataSource: this(),
          productDownloadDataSource: this(),
        ),
      )
      ..registerLazySingleton<ProductSearchReposotiry>(
        () => ProductSearchRepositoryImpl(
          productSearchRemoteDataSource: this(),
        ),
      )
      ..registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
          productRemoteDataSource: this(),
          productLocalDataSource: this(),
        ),
      )
      ..registerLazySingleton<BookmarkRepository>(
        BookmarkRepositoryImpl.new,
      )
      ..registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(
          homeDataSource: this(),
          homeLocalDataSource: this(),
        ),
      )
      ..registerLazySingleton<CountryRepository>(
        () => CountryRepositoryImpl(
          countryRemoteDataSource: this(),
        ),
      )
      ..registerLazySingleton<DeviceRepository>(
        () => DeviceRepositoryImpl(
          deviceDataSource: this(),
        ),
      )
      ..registerLazySingleton<MySelectionRepository>(
        () => MySelectionRepositoryImpl(
          mySelectionsDataSource: this(),
        ),
      )
      ..registerLazySingleton<UserAccountRepository>(
        () => UserAccountRepositoryImpl(
          userSettingsLocalDataSource: this(),
          userAccountRemoteDataSource: this(),
          userAccountLocalDataSource: this(),
        ),
      );
  }

  void registerDataSources() {
    this
      ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImpl(
            dio: this(), appSettings: this()),
      )
      ..registerLazySingleton<ProductLocalDataSource>(
          () => ProductLocalDataSourceImpl(this()))
      ..registerLazySingleton<ProductChaptersLocalDataSource>(
          () => ProductChaptersLocalDataSourceImpl(this()))
      ..registerLazySingleton<DocumentRemoteDataSource>(
        () => DocumentRemoteDataSourceImpl(dio: this()),
      )
      ..registerLazySingleton<DocumentLocalDataSource>(
        () => DocumentLocalDataSourceImpl(this()),
      )
      ..registerLazySingleton<ReadingStatsLocalDataSource>(
        () => ReadingStatsLocalDataSourceImpl(this()),
      )
      ..registerLazySingleton<UserAccountLocalDataSource>(
        () => UserAccountLocalDataSourceImpl(this()),
      )
      ..registerLazySingleton<UserSettingsLocalDataSource>(
        () => UserSettingsLocalDataSourceImpl(this()),
      )
      ..registerLazySingleton<ProductDownloadProgressLocalDataSource>(
        ProductDownloadProgressLocalDataSourceImpl.new,
      )
      ..registerLazySingleton<BookmarksLocalDataSource>(
        () => BookmarksLocalDataSourceImpl(this()),
      )
      ..registerLazySingleton<HomeLocalDataSource>(
        () => HomeLocalDataSourceImpl(this(), this()),
      )
      ..registerLazySingleton<ProductRemoteDataSource>(
          () => ProductRemoteDataSourceImpl(
                dio: this(),
                appSettings: this(),
              ))
      ..registerLazySingleton<ProductSearchRemoteDataSource>(
          () => ProductSearchRemoteDataSourceImpl(
                dio: this(),
                appSettings: this(),
              ))
      ..registerLazySingleton<MySelectionRemoteDataSourceImpl>(
          () => MySelectionRemoteDataSourceImpl(
                dio: this(),
                appSettings: this(),
              ))
      ..registerLazySingleton<DeviceRemoteDataSource>(
          () => DeviceRemoteDataSourceImpl(
                dio: this(),
                appSettings: this(),
              ))
      ..registerLazySingleton<CountryConfigRemoteDataSource>(
          () => CountryConfigRemoteDataSourceImpl(
                dio: this(),
                appSettings: this(),
              ))
      ..registerLazySingleton<HomeRemoteDataSource>(
          () => HomeRemoteDataSourceImpl(
                dio: this(),
                appSettings: this(),
              ))
      ..registerLazySingleton<BookMarkRemoteDataSource>(
          () => BookMarkRemoteDataSourceImpl(
                dio: this(),
                appSettings: this(),
              ))
      ..registerLazySingleton<InAppSubscriptionRequestDataSource>(
          () => InAppSubscriptionRequestDataSourceImpl(
                dio: this(),
                appSettings: this(),
              ))
      ..registerLazySingleton<MySelectionsRemoteDataSource>(
          () => MySelectionRemoteDataSourceImpl(
                dio: this(),
                appSettings: this(),
              ))
      ..registerLazySingleton<AccountPremiumTokenDataSource>(
          () => AccountPremiumTokenDataSourceImpl(
                dio: this(),
                appSettings: this(),
              ))
      ..registerLazySingleton<CountryConfigRepository>(
          () => CountryConfigRepositoryImpl(this(), this()))
      ..registerLazySingleton<UserAccountRemoteDataSource>(
          () => UserAccountRemoteDataSourceImpl(
                premiumTokenDataSource: this(),
                dio: this(),
                appSettings: this(),
              ));
  }

  Future<void> setupDatabase() async {
    final FileService fileService = this();
    await fileService.initialize();
    final path = fileService.getDatabasePath();

    final isar = await Isar.open([
      BookmarkEntitySchema,
      ProductEntitySchema,
      HomeEntitySchema,
      UserGlobalSettingsEntitySchema,
      ReadingStatsEntitySchema,
      ProductDocumentPasswordEntitySchema,
      CurrentUserAccountEntitySchema,
      AudioChapterEntitySchema
    ], directory: path);

    registerLazySingleton(() => isar);
  }
}
