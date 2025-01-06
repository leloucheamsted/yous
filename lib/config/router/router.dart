import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/go_route_extension.dart';
import 'package:youscribe/config/router/go_router_refresh_stream.dart';
import 'package:youscribe/config/router/route_base_extension.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/authentication/authentication_status.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/use_cases/products/check_product_access_rights_use_case.dart';
import 'package:youscribe/presentation/blocs/audio_player/audio_player_cubit.dart';
import 'package:youscribe/presentation/blocs/author/author_bloc.dart';
import 'package:youscribe/presentation/blocs/collection/collection_bloc.dart';
import 'package:youscribe/presentation/blocs/epub_reader/epub_reader_bloc.dart';
import 'package:youscribe/presentation/blocs/library/second_level/classifications_bloc.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_selection_details/my_selection_details_bloc.dart';
import 'package:youscribe/presentation/blocs/notifications/notification_bloc.dart';
import 'package:youscribe/presentation/blocs/products/details/product_bloc.dart';
import 'package:youscribe/presentation/blocs/products/in_selection/products_in_selection_bloc.dart';
import 'package:youscribe/presentation/blocs/publisher/publisher_bloc.dart';
import 'package:youscribe/presentation/blocs/search/search_results/search_results_bloc.dart';
import 'package:youscribe/presentation/blocs/suggestion/suggestion_bloc.dart';
import 'package:youscribe/presentation/blocs/token/token_bloc.dart';
import 'package:youscribe/presentation/screens/account/account_screen.dart';
import 'package:youscribe/presentation/screens/account/help_screen.dart';
import 'package:youscribe/presentation/screens/account/my_tokens_screen.dart';
import 'package:youscribe/presentation/screens/account/notification_screen.dart';
import 'package:youscribe/presentation/screens/account/personnal_legal_notice_screen.dart';
import 'package:youscribe/presentation/screens/audio_player/audio_player_screen.dart';
import 'package:youscribe/presentation/screens/auth/forgot_password_screen.dart';
import 'package:youscribe/presentation/screens/auth/sign_in_screen.dart';
import 'package:youscribe/presentation/screens/auth/sign_up_screen.dart';
import 'package:youscribe/presentation/screens/auth/welcome_screen.dart';
import 'package:youscribe/presentation/screens/author/author_screen.dart';
import 'package:youscribe/presentation/screens/collections/collection_details_screen.dart';
import 'package:youscribe/presentation/screens/dialog/recommandation_dialog.dart';
import 'package:youscribe/presentation/screens/epub_reader/epub_reader.dart';
import 'package:youscribe/presentation/screens/home/home_screen.dart';
import 'package:youscribe/presentation/screens/library/classification_screen.dart';
import 'package:youscribe/presentation/screens/library/library_screen.dart';
import 'package:youscribe/presentation/screens/loading/app_loading_screen.dart';
import 'package:youscribe/presentation/screens/my_lists/my_lists_screen.dart';
import 'package:youscribe/presentation/screens/my_lists/selections/my_selection_details_screen.dart';
import 'package:youscribe/presentation/screens/products/product_details_screen.dart';
import 'package:youscribe/presentation/screens/products/product_in_selection_screen.dart';
import 'package:youscribe/presentation/screens/publisher/publisher_screen.dart';
import 'package:youscribe/presentation/screens/search/search_results_screen.dart';
import 'package:youscribe/presentation/screens/search/search_results_screen_params.dart';
import 'package:youscribe/presentation/screens/search/search_screen.dart';
import 'package:youscribe/presentation/screens/shared/shell_screen.dart';
import 'package:youscribe/presentation/screens/suggestion/suggeston_screen.dart';

abstract class AppRouter {
  static Page<dynamic> createFadeTransitionOnPage(
      Widget page, BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      child: page,
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _rootNavigationKey = navigatorKey;
  static final GlobalKey<NavigatorState> _shellNavigationKey =
      GlobalKey<NavigatorState>();

  static final List<RouteBase> routes = [
    ShellRoute(
      navigatorKey: _shellNavigationKey,
      pageBuilder: (context, state, child) =>
          createFadeTransitionOnPage(ShellScreen(child: child), context, state),
      routes: [
        GoRoute(
          path: '/${Routes.home}',
          name: Routes.home,
          parentNavigatorKey: _shellNavigationKey,
          pageBuilder: (context, state) =>
              createFadeTransitionOnPage(const HomeScreen(), context, state),
        )..setProtected(),
        GoRoute(
          path: '/${Routes.library}',
          name: Routes.library,
          parentNavigatorKey: _shellNavigationKey,
          pageBuilder: (context, state) =>
              createFadeTransitionOnPage(const LibraryScreen(), context, state),
        )..setProtected(),
        GoRoute(
          path: '/${Routes.search}',
          name: Routes.search,
          parentNavigatorKey: _shellNavigationKey,
          pageBuilder: (context, state) =>
              createFadeTransitionOnPage(const SearchScreen(), context, state),
        )..setProtected(),
        GoRoute(
          path: '/${Routes.myLists}',
          name: Routes.myLists,
          parentNavigatorKey: _shellNavigationKey,
          pageBuilder: (context, state) => createFadeTransitionOnPage(
              MyListsScreen(isFirstOpenMyListTab: state.extra! as bool),
              context,
              state),
        )..setProtected(),
        GoRoute(
          path: '/${Routes.account}',
          name: Routes.account,
          parentNavigatorKey: _shellNavigationKey,
          pageBuilder: (context, state) =>
              createFadeTransitionOnPage(const AccountScreen(), context, state),
        )..setProtected(),
      ],
    ),
    GoRoute(
      path: '/${Routes.personnalLegalNotices}',
      name: Routes.personnalLegalNotices,
      parentNavigatorKey: _rootNavigationKey,
      builder: (context, state) {
        final params = GoRouterState.of(context).uri.queryParameters;
        final content = params[Routes.contentLegalParamName];
        return PersonnalLegalNoticeScreen(content: content ?? '');
      },
    )..setProtected(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.appLoading}',
      name: Routes.appLoading,
      builder: (context, state) => const AppLoadingScreen(),
    )..setPublic(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.classification}',
      name: Routes.classification,
      builder: (context, state) {
        final previousFacets =
            GoRouterState.of(context).extra! as List<BaseProductFacetEntity>;
        if (previousFacets.isNull || previousFacets.isEmpty) {
          throw Exception(
              'classification  screen requires previous facets list');
        }
        final facetName = previousFacets.last.label;
        if (facetName.isNullOrEmpty) {
          throw Exception(
              'classification  screen requires previous facet name');
        }

        return BlocProvider(
            create: (context) => ClassificationsBloc()
              ..add(ClassificationsInitialEvent(
                  previousFacets: previousFacets,
                  selectedFacetId: previousFacets.last.id!)),
            child: ClassificationScreen(
                productFacets: previousFacets, facetName: facetName!));
      },
    )..setProtected(),
    GoRoute(
        parentNavigatorKey: _rootNavigationKey,
        path: '/${Routes.searchResults}',
        name: Routes.searchResults,
        builder: (context, state) {
          if (state.extra == null) {
            throw Exception('Search results screen requires extra params');
          }
          final paramsQuery = GoRouterState.of(context).uri.queryParameters;
          final params = state.extra! as SearchResultScreenParams;
          // if (!paramsQuery.containsKey(Routes.isYsClassfificationParamName))
          // {
          //   return BlocProvider(
          //       create: (context) => SearchResultsBloc(),
          //       child: SearchResultsScreen(
          //         params: params,
          //         isYsClassfification: false,
          //       ));
          // }
          final isYsClassfification =
              paramsQuery[Routes.isYsClassfificationParamName] == 'true';

          return BlocProvider(
              create: (context) => SearchResultsBloc(),
              child: SearchResultsScreen(
                params: params,
                isYsClassfification: isYsClassfification,
              ));
        })
      ..setProtected(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.welcome}',
      name: Routes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    )..setPublic(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.collectionDetails}',
      name: Routes.collectionDetails,
      builder: (context, state) {
        final params = GoRouterState.of(context).uri.queryParameters;
        if (!params.containsKey(Routes.collectionIdParamName)) {
          throw Exception('Collection details screen requires collection id');
        }
        final collectionIdStr = params[Routes.collectionIdParamName];
        final collectionTitleStr = params[Routes.collectionTitleParamName];

        if (collectionIdStr.isNullOrEmpty) {
          throw Exception('Collection details screen requires collection id');
        }
        final collectionId = int.tryParse(collectionIdStr!);
        final Locale myLocale = Localizations.localeOf(context);
        return BlocProvider(
          create: (context) => CollectionDetailsBloc()
            ..add(InitCollectionEvent(
                collectionId, myLocale.languageCode, collectionTitleStr)),
          child: CollectionDetailsScreen(
              collectionId: collectionId!,
              collectionTitle: collectionTitleStr!),
        );
      },
    )..setProtected(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.authorPage}',
      name: Routes.authorPage,
      builder: (context, state) {
        final params = GoRouterState.of(context).uri.queryParameters;
        if (!params.containsKey(Routes.authorIdParamName)) {
          throw Exception('Author details screen requires author id');
        }
        final authorIdStr = params[Routes.authorIdParamName];
        //TODO: later, let the name be gotten from API directly
        final authorName = params[Routes.authorTitleParamName];

        if (authorIdStr.isNullOrEmpty) {
          throw Exception('Author details screen requires author id');
        }
        final authorId = int.tryParse(authorIdStr!);
        final Locale myLocale = Localizations.localeOf(context);
        return BlocProvider(
          create: (context) => AuthorBloc()
            ..add(InitAuthorEvent(
                authorId, myLocale.languageCode, authorName ?? '')),
          child:
              AuthorScreen(authorId: authorId!, authorName: authorName ?? ''),
        );
      },
    )..setProtected(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.productsInYsSelection}',
      name: Routes.productsInYsSelection,
      builder: (context, state) {
        final params = GoRouterState.of(context).uri.queryParameters;
        if (!params.containsKey(Routes.ysSelectionIdParamName)) {
          throw Exception(
              'Products in Selection screen requires ys selection id');
        }
        final ysSelectionId = params[Routes.ysSelectionIdParamName];

        return BlocProvider(
          create: (context) => ProductsInSelectionBloc()
            ..add(InitProductInSelectionEvent(ysSelectionId)),
          child: ProductInSelectionScreen(
            selectionId: ysSelectionId!,
          ),
        );
      },
    )..setProtected(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.selectionDetails}',
      name: Routes.selectionDetails,
      builder: (context, state) {
        final params = GoRouterState.of(context).uri.queryParameters;
        if (!params.containsKey(Routes.selectionIdParamName)) {
          throw Exception('Selection details screen requires selection id');
        }
        final selectionIdStr = params[Routes.selectionIdParamName];
        if (selectionIdStr.isNullOrEmpty) {
          throw Exception('Selection details screen requires selection id');
        }
        final selectionId = int.tryParse(selectionIdStr!);
        //TODO: later, let the name be gotten from API directly
        final selectionTitle = params[Routes.selectionTitleParamName];
        return BlocProvider(
          create: (context) => MySelectionDetailsBloc()
            ..add(InitMySelectionDetailsEvent(selectionId)),
          child: MySelectionDetailsScreen(
            selectionId: selectionId!,
            selectionnTitle: selectionTitle ?? '',
          ),
        );
      },
    )..setProtected(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.publisherProducts}',
      name: Routes.publisherProducts,
      builder: (context, state) {
        final params = GoRouterState.of(context).uri.queryParameters;
        if (!params.containsKey(Routes.publisherIdParamName)) {
          throw Exception('Publisher details screen requires publisher id');
        }
        final publisherIdStr = params[Routes.publisherIdParamName];
        //TODO: later, let the name be gotten from API directly
        final publisherName = params[Routes.publisherTitleParamName];

        if (publisherIdStr.isNullOrEmpty) {
          throw Exception('Publisher details screen requires publisher id');
        }
        final publisherId = int.tryParse(publisherIdStr!);
        final Locale myLocale = Localizations.localeOf(context);
        return BlocProvider(
          create: (context) => PublisherBloc()
            ..add(InitPublisherEvent(
                publisherId, myLocale.languageCode, publisherName ?? '')),
          child: PublisherScreen(
              publisherId: publisherId!, publisherName: publisherName ?? ''),
        );
      },
    )..setProtected(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.productDetails}',
      name: Routes.productDetails,
      builder: (context, state) {
        final params = GoRouterState.of(context).uri.queryParameters;
        if (!params.containsKey(Routes.productIdParamName)) {
          throw Exception('Product details screen requires product id');
        }
        final productIdStr = params[Routes.productIdParamName];
        if (productIdStr.isNullOrEmpty) {
          throw Exception('Product details screen requires product id');
        }
        final productId = int.tryParse(productIdStr!);
        final Locale myLocale = Localizations.localeOf(context);
        return BlocProvider(
          create: (context) => ProductDetailsBloc()
            ..add(InitProductEvent(productId, myLocale.languageCode)),
          child: ProductDetailsScreen(productId: productId!),
        );
      },
    )..setProtected(),
    GoRoute(
      path: '/${Routes.myTokens}',
      name: Routes.myTokens,
      parentNavigatorKey: _rootNavigationKey,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => TokenBloc()..add(const InitTokenEvent()),
          child: const MyTokensScreen(),
        );
      },
    )..setProtected(),
    GoRoute(
      path: '/${Routes.notifications}',
      name: Routes.notifications,
      parentNavigatorKey: _rootNavigationKey,
      builder: (context, state) {
        if (state.extra == null) {
          throw Exception(
              'Notification  screen requires notification Option params');
        }

        final notificationOption = state.extra! as NotificationOption;
        return BlocProvider(
          create: (context) => NotificationBloc()
            ..add(InitNotificationEvent(options: notificationOption)),
          child: NotificationScreen(option: notificationOption),
        );
      },
    )..setProtected(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.signIn}',
      name: Routes.signIn,
      builder: (context, state) => const SignInScreen(),
    )..setPublic(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.forgotPassword}',
      name: Routes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    )..setPublic(),
    GoRoute(
      path: '/${Routes.signUp}',
      name: Routes.signUp,
      parentNavigatorKey: _rootNavigationKey,
      builder: (context, state) => const SignUpScreen(),
    )..setPublic(),
    GoRoute(
        path: '/${Routes.help}',
        name: Routes.help,
        parentNavigatorKey: _rootNavigationKey,
        builder: (context, state) {
          if (state.extra == null) {
            throw Exception(
                'Notification  screen requires notification Option params');
          }
          return HelpScreen(isTokenExpand: state.extra! as bool);
        })
      ..setProtected(),
    GoRoute(
        parentNavigatorKey: _rootNavigationKey,
        path: '/${Routes.epubReader}',
        name: Routes.epubReader,
        builder: (context, state) {
          final params = GoRouterState.of(context).uri.queryParameters;
          final path = params[Routes.pathParamName].toString();
          final productId =
              int.parse(params[Routes.productIdParamName].toString());

          return BlocProvider(
              create: (context) => EpubReaderBloc()
                ..add(InitEpubReaderEvent(path: path, productId: productId)),
              child: const EpubReader());
        })
      ..setProtected(),
    GoRoute(
        name: Routes.audioPlayer,
        path: '/${Routes.audioPlayer}',
        parentNavigatorKey: _rootNavigationKey,
        builder: (context, state) {
          final params = GoRouterState.of(context).uri.queryParameters;
          final productId = params[Routes.productIdParamName];
          final productAccessType = params[Routes.productAccessTypeParamName];
          final intProductId = int.tryParse(productId!)!;
          final realProductAccessState = ProductAccessState.values
              .byName(productAccessType!.split('.')[1]);
          AudioPlayer player = locator();

          if (state.extra.isNotNull) {
            final data = state.extra! as Map<String, dynamic>;
            player = data['player'] as AudioPlayer;
            return BlocProvider(
              create: (context) => AudioPlayerCubit(),
              child: AudioPlayerScreen(
                player: player,
                product: data['product'] as ProductEntity,
              ),
            );
          }
          return BlocProvider(
            create: (context) => AudioPlayerCubit()
              ..init(
                productId: intProductId,
                productAccessState: realProductAccessState,
              ),
            child: const AudioPlayerScreen(),
          );
        })
      ..setProtected(),
    GoRoute(
      name: Routes.recommandations,
      path: '/${Routes.recommandations}',
      pageBuilder: (context, state) => const RecommandationDialog(),
    )..setProtected(),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: '/${Routes.suggestions}',
      name: Routes.suggestions,
      builder: (context, state) {
        return BlocProvider(
          create: (context) =>
              SuggestionBloc()..add(const InitSuggestionEvent()),
          child: const SuggestionScreen(),
        );
      },
    )..setProtected(),
  ];

  static GoRouter? _router;

  static GoRouter routerOf(BuildContext context) => _router ??= GoRouter(
        redirect: _guardRedirect,
        initialLocation: '/${Routes.appLoading}',
        navigatorKey: _rootNavigationKey,

        ///Here is where the auth manager's auth status stream is listened.
        refreshListenable: GoRouterRefreshStream(
            locator<AuthenticationManager>().authenticationStatusSteam),
        routes: routes,
      );

  static Future<String?> _guardRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final authenticationStatus =
        locator<AuthenticationManager>().authenticationStatus;

    /// Recursively get all routes and subroutes in a one-dimensional list
    /// This will work for any level of nesting
    final routes = AppRouter.routes.map((route) => route.flatten()).expand(
          (routeList) => routeList,
        );
    final matches = _router?.configuration
            .findMatch(
              state.uri.toString(),
            )
            .routes
            .map((route) => route.flatten())
            .expand(
              (routeList) => routeList,
            ) ??
        routes;

    // Compute current route
    final currentRoute = matches.last;
    return switch (authenticationStatus) {
      AuthenticationStatus.authenticated when currentRoute.isPublic =>
        '/${Routes.home}',
      AuthenticationStatus.unauthenticated
          when currentRoute.isProtected ||
              currentRoute.name == Routes.appLoading =>
        '/${Routes.welcome}',
      _ => null,
    };
  }
}
