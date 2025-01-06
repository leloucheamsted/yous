import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class SaveUserSelectionsUseCase
    extends AsyncUseCase<List<SimpleLibraryEntity>, void> {
  SaveUserSelectionsUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOrResult<void> execute(List<SimpleLibraryEntity>? params) async {
    final response = await _userAccountRepository.saveUserSelections(params!);
    return Ok(response);
  }
}
