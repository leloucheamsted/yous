import 'package:youscribe/core/models/responses/unfollow_response_model.dart';

class ProductFollowOutputEntity {
  ProductFollowOutputEntity(
      {this.isAuthorFollowed, this.isEditorFollowed, this.isSubthemeFollowed});
  bool? isAuthorFollowed;
  bool? isEditorFollowed;
  bool? isSubthemeFollowed;
}

class BaseFollowResponseEntity {
  BaseFollowResponseEntity({required this.id});
  int id;
}

class FollowResponseEntity extends BaseFollowResponseEntity {
  FollowResponseEntity({
    required this.isFollowed,
    required super.id,
  });
  bool isFollowed;
}

class UnfollowResponseEntity extends BaseFollowResponseEntity {
  UnfollowResponseEntity({required this.isUnfollowed, required super.id});
  factory UnfollowResponseEntity.fromModel(UnfollowResponseModel model) =>
      UnfollowResponseEntity(isUnfollowed: model.isUnfollowed, id: model.id);
  bool isUnfollowed;
}

class ProductFollowRequestEntity {
  ProductFollowRequestEntity({required this.productId});
  int productId;
}

class FollowRequestEntity {
  FollowRequestEntity({required this.id});
  int id;
}

class BulkUnFollowResponseEntity {
  BulkUnFollowResponseEntity({required this.results});

  // ignore: use_setters_to_change_properties
  void fromUnfollowResponse(List<UnfollowResponseEntity> unfollowResponse) {
    results = unfollowResponse;
  }

  List<UnfollowResponseEntity> results;
}
