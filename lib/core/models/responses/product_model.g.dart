// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      imageUrls: (json['ImageUrls'] as List<dynamic>?)
          ?.map((e) => ThumbnailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      playlistModel: (json['PlaylistModel'] as List<dynamic>?)
          ?.map((e) => AudioChapterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      people: (json['People'] as List<dynamic>?)
          ?.map((e) => ProductGetPeople.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['Tags'] as List<dynamic>?)
          ?.map((e) => ProductGetTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      offers: (json['Offers'] as List<dynamic>?)
          ?.map((e) => ProductOfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['Id'] as int?,
      title: json['Title'] as String?,
      description: json['Description'] as String?,
      author: json['Author'] as String?,
      narrator: json['Narrator'] as String?,
      isFavorite: json['IsFavorite'] as bool?,
      isOffline: json['IsOffline'] as bool?,
      languagesIsoCode: (json['LanguagesIsoCode'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      extensions: (json['Extensions'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      right: json['Right'] as int?,
      estimatedReadTime: json['EstimatedReadTime'] as String?,
      ownerDisplayableUserName: json['OwnerDisplayableUserName'] as String?,
      ownerUserName: json['OwnerUserName'] as String?,
      ownerId: json['OwnerId'] as int?,
      rentalPriceByPages: (json['RentalPriceByPages'] as num?)?.toDouble(),
      categoryId: json['CategoryId'] as int?,
      themeId: json['ThemeId'] as int?,
      rootThemeId: json['RootThemeId'] as int?,
      documentProtectionTypeName: json['DocumentProtectionTypeName'] as String?,
      voteEligibility: json['VoteEligibility'] as bool?,
      voteValue: json['VoteValue'] as int?,
      voteCampainLabel: json['VoteCampainLabel'] as String?,
      totalDuration: (json['TotalDuration'] as num?)?.toDouble(),
      nbParts: json['NbParts'] as int?,
      numberOfPages: json['NumberOfPages'] as int?,
      classificationsIds: (json['ClassificationsIds'] as List<dynamic>?)
          ?.map((e) => e as int?)
          .toList(),
      publishDate: json['PublishDate'] == null
          ? null
          : DateTime.parse(json['PublishDate'] as String),
      origin: json['Origin'] as String?,
      authorId: json['AuthorId'] as int?,
      collectionId: json['CollectionId'] as int?,
      collectionTitle: json['CollectionTitle'] as String?,
      isEditorFollowed: json['IsEditorFollowed'] as bool?,
      isAuthorFollowed: json['IsAuthorFollowed'] as bool?,
      document: json['Document'] == null
          ? null
          : ProductGetDocument.fromJson(
              json['Document'] as Map<String, dynamic>),
      comment: json['Comment'] == null
          ? null
          : ProductCommentaryModel.fromJson(
              json['Comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Title': instance.title,
      'Description': instance.description,
      'Author': instance.author,
      'Narrator': instance.narrator,
      'IsFavorite': instance.isFavorite,
      'IsOffline': instance.isOffline,
      'LanguagesIsoCode': instance.languagesIsoCode,
      'Extensions': instance.extensions,
      'Right': instance.right,
      'EstimatedReadTime': instance.estimatedReadTime,
      'OwnerDisplayableUserName': instance.ownerDisplayableUserName,
      'OwnerUserName': instance.ownerUserName,
      'OwnerId': instance.ownerId,
      'RentalPriceByPages': instance.rentalPriceByPages,
      'CategoryId': instance.categoryId,
      'ThemeId': instance.themeId,
      'RootThemeId': instance.rootThemeId,
      'DocumentProtectionTypeName': instance.documentProtectionTypeName,
      'VoteEligibility': instance.voteEligibility,
      'VoteValue': instance.voteValue,
      'VoteCampainLabel': instance.voteCampainLabel,
      'TotalDuration': instance.totalDuration,
      'NbParts': instance.nbParts,
      'NumberOfPages': instance.numberOfPages,
      'ClassificationsIds': instance.classificationsIds,
      'PublishDate': instance.publishDate?.toIso8601String(),
      'Origin': instance.origin,
      'AuthorId': instance.authorId,
      'CollectionId': instance.collectionId,
      'CollectionTitle': instance.collectionTitle,
      'IsEditorFollowed': instance.isEditorFollowed,
      'IsAuthorFollowed': instance.isAuthorFollowed,
      'People': instance.people,
      'Document': instance.document,
      'Tags': instance.tags,
      'PlaylistModel': instance.playlistModel,
      'Offers': instance.offers,
      'ImageUrls': instance.imageUrls,
      'Comment': instance.comment,
    };
