import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/errors/api_error.dart';
import 'package:youscribe/core/repositories/authentication_repository.dart';
import 'package:youscribe/data/data_sources/authentication_data_sources/authentication_remote_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_account_local_data_source.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required AuthenticationRemoteDataSource authenticationRemoteDataSource,
    required UserAccountLocalDataSource authenticationLocalDataSource,
  })  : _authenticationRemoteDataSource = authenticationRemoteDataSource,
        _authenticationLocalDataSource = authenticationLocalDataSource;

  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final UserAccountLocalDataSource _authenticationLocalDataSource;

  @override
  FutureOrResult<CurrentUserAccountEntity?> login(
      [({String userName, String password})? credentials]) async {
    return Result.tryCatchAsync(
      () async {
        final ({String userName, String password})? creds = credentials;

        if (credentials.isNull) {
          throw Exception('You must provide userName and password to login');
        }

        final loginResponse = await _authenticationRemoteDataSource.login(
          creds!.userName,
          creds.password,
        );

        final user = CurrentUserAccountEntity.fromMobileAccount(loginResponse!);
        await _authenticationLocalDataSource.save(user);

        return user;
      },
      (error) => error.asAppException(fromServer: true),
    );
  }

  @override
  FutureOrResult<void> logOut() async => Result.tryCatchAsync(
        _authenticationLocalDataSource.delete,
        (error) =>
            error is AppException ? error : ServerException(error.toString()),
      );

  @override
  FutureOrResult<CurrentUserAccountEntity?> signUp(String email,
          {required String countryCode,
          String? giftCode,
          bool createSubscription = true}) =>
      Result.tryCatchAsync(
        () async {
          final signUpResponse = await Result.tryCatchAsync(
            () => _authenticationRemoteDataSource.signUp(
              email,
              countryCode: countryCode,
              giftCode: giftCode,
              createSubscription: createSubscription,
            ),
            (error) => error.asAppException(fromServer: true),
          );

          if (signUpResponse.isErr) {
            return throw signUpResponse.err!;
          }

          if (signUpResponse.ok.isNotNull) {
            Result.tryCatch(
              () => _authenticationLocalDataSource.save(
                  CurrentUserAccountEntity.fromMobileAccount(
                      signUpResponse.ok!)),
              (error) => error.asAppException(),
            );

            return CurrentUserAccountEntity.fromMobileAccount(
                signUpResponse.ok!);
          }
          return null;
        },
        (error) => error.asAppException(fromServer: true),
      );

  @override
  FutureOrResult<CurrentUserAccountEntity?> authenticateWithFacebook(
      [({
        String accessToken,
        String countryCode,
        String? giftCode,
        bool createSubscription
      })? credentials]) async {
    final loginResponse =
        await _authenticationRemoteDataSource.authenticateWithFacebook(
      accessToken: credentials!.accessToken,
      countryCode: credentials.countryCode,
      giftCode: credentials.giftCode,
      createSubscription: credentials.createSubscription,
    );
    final user = CurrentUserAccountEntity.fromMobileAccount(loginResponse!);
    await _authenticationLocalDataSource.save(user);

    return Ok(user);
  }

  @override
  Future<bool> forgotPassword(String email) async {
    return _authenticationRemoteDataSource.forgotPassword(email);
  }

  @override
  FutureOrResult<CurrentUserAccountEntity?> authenticateWithApple(
      [({
        String appleUserId,
        String countryCode,
        bool createSubscription,
        String email,
        String languageCode,
        String subscriptionCode,
        String tokenId,
        String userName
      })? credentials]) async {
    final loginResponse =
        await _authenticationRemoteDataSource.authenticateWithApple(
            appleUserId: credentials!.appleUserId,
            countryCode: credentials.countryCode,
            userName: credentials.userName,
            languageCode: credentials.languageCode,
            subscriptionCode: credentials.subscriptionCode,
            createSubscription: credentials.createSubscription,
            tokenId: credentials.tokenId,
            email: credentials.email);
    //final user = CurrentUserAccountEntity.fromMobileAccount(loginResponse);
    await _authenticationLocalDataSource.save(loginResponse!);
    return Ok(loginResponse);
  }
}
