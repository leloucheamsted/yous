import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/bookmark_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/models/responses/bookmark_model.dart';
import 'package:youscribe/core/repositories/bookmark_repository.dart';

class SaveBookmarkUseCase
    extends AsyncUseCase<SaveBookmarkUseCaseParameters, bool> {
  SaveBookmarkUseCase();
  final BookmarkRepository _bookmarkRepository = locator();
  final ConnectivityService _connectivityService = locator();
  @override
  FutureOrResult<bool> execute(SaveBookmarkUseCaseParameters? params) async {
    try {
      final user = await AuthenticationManager.getCurrentUser();
      if (await _connectivityService.isInternetAvailable) {
        await _bookmarkRepository.upsertBookmarkAsync(BookmarkEntity(
            userId: user!.id!,
            productId: params?.productId ?? 0,
            pageNumber: params!.pageNumber,
            dateUpdate: DateTime.now(),
            progress: params.progress.toInt(),
            type: params.isAutoBookmark
                ? AccountBookmarkType.auto
                : AccountBookmarkType.user));
      }
      await _bookmarkRepository.upsertBookmark(
          params!.productId,
          BookmarkEntity(
              userId: user!.id!,
              productId: params.productId,
              pageNumber: params.pageNumber,
              dateUpdate: DateTime.now(),
              progress: params.progress.toInt(),
              type: params.isAutoBookmark
                  ? AccountBookmarkType.auto
                  : AccountBookmarkType.user));
    } on APIRequestException catch (e) {
      return Err(e);
    }

    return const Ok(true);
  }
}

class SaveBookmarkUseCaseParameters {
  SaveBookmarkUseCaseParameters({
    required this.productId,
    required this.pageNumber,
    required this.progress,
    this.isAutoBookmark = true,
  });
  int productId;
  int pageNumber;
  double progress;
  bool isAutoBookmark;
}
