import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class RetreiveUserSelectionsUseCase
    extends AsyncUseCase<void, List<SimpleLibraryEntity>> {
  RetreiveUserSelectionsUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOrResult<List<SimpleLibraryEntity>> execute(void params) async {
    final response = await _userAccountRepository.retrieveUserSelections();
    return Ok(response ?? []);
  }
}
