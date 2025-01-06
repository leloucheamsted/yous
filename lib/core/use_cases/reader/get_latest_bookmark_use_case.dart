import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/bookmark_entity.dart';
import 'package:youscribe/core/repositories/bookmark_repository.dart';

class GetBookmarkUseCase extends AsyncUseCase<int, BookmarkEntity?> {
  GetBookmarkUseCase();
  final BookmarkRepository _bookmarkRepository = locator();

  @override
  // ignore: avoid_renaming_method_parameters
  FutureOrResult<BookmarkEntity?> execute(int? productId) async {
    final result = await _bookmarkRepository.getAutoBookmark(productId!);
    return Ok(result);
  }
}
