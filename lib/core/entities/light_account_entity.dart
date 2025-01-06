import 'package:youscribe/core/models/responses/light_account_model.dart';

class LightAccountEntity {
  LightAccountEntity({
    required LightAccountModel model,
  })  : id = model.id,
        displayableUserName = model.displayableUserName,
        biography = model.biography,
        isFollowed = model.isFollowed,
        avatarUrls = model.avatarUrls?.map((e) => e.url!).toList() ?? [];

  int? id;
  String? displayableUserName;
  String? biography;
  bool? isFollowed;
  List<String>? avatarUrls;
}
