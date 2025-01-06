import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/models/responses/mobile_account_model.dart';
part 'current_user_account_entity.g.dart';

@collection
class CurrentUserAccountEntity extends BaseEntity {
  CurrentUserAccountEntity();
  CurrentUserAccountEntity.fromParams({
    required super.localId,
    this.firstName,
    this.lastName,
    this.firebaseToken,
    this.id = 0,
    this.premiumIsAllowed = false,
    this.classificationTreeId,
    this.userName,
    this.email,
    this.token,
    this.imageUrl,
    this.trackingId = "",
    this.isSubscriber = false,
    this.cobranding,
    this.additionalRightRequired = false,
    this.additionalRightExpiration,
    this.profileImageUrls,
    this.profilePic,
    this.userSelections,
  });

  CurrentUserAccountEntity.fromMobileAccount(MobileAccountModel account) {
    classificationTreeId = null;
    if (account.avatarUrls != null && account.avatarUrls!.isNotEmpty) {
      profileImageUrls = account.avatarUrls!.map((a) => a.url!).toList();
      profilePic = profileImageUrls?.first;
    }
    userName = account.userName;
    id = account.id ?? 0;
    email = account.email;
    token = account.token;
    trackingId = account.trackingId ?? "";
    isSubscriber = account.isSubscriber;
    cobranding = account.cobranding;
    additionalRightExpiration = account.additionnalRightExpiration;
    additionalRightRequired = account.additionnalRightRequired;
  }

  CurrentUserAccountEntity copyWith({
    String? firstName,
    String? lastName,
    String? firebaseToken,
    int? id,
    bool? premiumIsAllowed,
    int? classificationTreeId,
    String? userName,
    String? email,
    String? token,
    String? imageUrl,
    String? trackingId,
    bool? isSubscriber,
    String? cobranding,
    bool? additionalRightRequired,
    DateTime? additionalRightExpiration,
    List<String>? profileImageUrls,
    String? profilePic,
    List<SimpleLibraryEntity>? userSelections,
  }) {
    return CurrentUserAccountEntity.fromParams(
      localId: localId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      firebaseToken: firebaseToken ?? this.firebaseToken,
      id: id ?? this.id,
      premiumIsAllowed: premiumIsAllowed ?? this.premiumIsAllowed,
      classificationTreeId: classificationTreeId ?? this.classificationTreeId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      token: token ?? this.token,
      imageUrl: imageUrl ?? this.imageUrl,
      trackingId: trackingId ?? this.trackingId,
      isSubscriber: isSubscriber ?? this.isSubscriber,
      cobranding: cobranding ?? this.cobranding,
      additionalRightRequired:
          additionalRightRequired ?? this.additionalRightRequired,
      additionalRightExpiration:
          additionalRightExpiration ?? this.additionalRightExpiration,
      profileImageUrls: profileImageUrls ?? this.profileImageUrls,
      profilePic: profilePic ?? this.profilePic,
      userSelections: userSelections ?? this.userSelections,
    );
  }

  String? firstName;
  String? lastName;
  String? firebaseToken;
  int? id = 0;
  bool? premiumIsAllowed = false;
  int? classificationTreeId;
  String? userName;
  String? email;
  String? token;
  String? imageUrl;
  String trackingId = "";
  bool? isSubscriber = false;
  String? cobranding;
  bool get isYSClassificationSettings => classificationTreeId == null;
  bool? additionalRightRequired = false;
  DateTime? additionalRightExpiration;
  List<String>? profileImageUrls;
  String? profilePic;
  List<SimpleLibraryEntity>? userSelections;
}
