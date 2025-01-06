import 'package:isar/isar.dart';
import 'package:youscribe/core/models/responses/canal_plus_config_text_item.dart';
import 'package:youscribe/core/models/responses/canalplus_config_model.dart';

part 'canalplus_config_entity.g.dart';

@embedded
class CanalplusConfigEntity {
  CanalplusConfigEntity({
    this.allowed,
    this.notSubscriberMessage,
  });

  factory CanalplusConfigEntity.fromModel(CanalplusConfigModel model) {
    List<CanalPlusConfigTextItemEntity>? notSubscriberMessage;
    if (model.notSubscriberMessage != null) {
      notSubscriberMessage = model.notSubscriberMessage!
          .map(CanalPlusConfigTextItemEntity.fromModel)
          .toList();
    } else {
      notSubscriberMessage = [];
    }

    return CanalplusConfigEntity(
      allowed: model.allowed,
      notSubscriberMessage: notSubscriberMessage,
    );
  }

  bool? allowed;
  List<CanalPlusConfigTextItemEntity>? notSubscriberMessage;
}

@embedded
class CanalPlusConfigTextItemEntity {
  CanalPlusConfigTextItemEntity({
    this.type = CanalPlusConfigTextItemType.text,
    this.value,
  });

  CanalPlusConfigTextItemEntity.fromModel(CanalPlusConfigTextItem model)
      : type = model.type,
        value = model.value;

  @enumerated
  CanalPlusConfigTextItemType type;
  String? value;
}
