// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_search_item_output_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSearchItemOutputModel _$ProductSearchItemOutputModelFromJson(
        Map<String, dynamic> json) =>
    ProductSearchItemOutputModel(
      id: json['Id'] as int?,
      origin: json['Origin'] as String?,
      category: json['Category'] == null
          ? null
          : ProductCategoryModel.fromJson(
              json['Category'] as Map<String, dynamic>),
      title: json['Title'] as String?,
      description: json['Description'] as String?,
      authors:
          (json['Authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ownerUserName: json['OwnerUserName'] as String?,
      ownerDisplayableUserName: json['OwnerDisplayableUserName'] as String?,
      nbPages: json['NbPages'] as int?,
      nbReads: json['NbReads'] as int?,
      avgScore: (json['AvgScore'] as num?)?.toDouble(),
      price: (json['Price'] as num?)?.toDouble(),
      nbVotes: json['NbVotes'] as int?,
      pertinenceWeight: (json['PertinenceWeight'] as num?)?.toDouble(),
      publicFormatExtensions: (json['PublicFormatExtensions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      extractPublicFormatExtensions:
          (json['ExtractPublicFormatExtensions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      thumbnailUrls: (json['ThumbnailUrls'] as List<dynamic>?)
          ?.map((e) => ImageUrlOutput.fromJson(e as Map<String, dynamic>))
          .toList(),
      extensions: (json['Extensions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      imageUrls: (json['ImageUrls'] as List<dynamic>?)
          ?.map((e) => ImageUrlOutput.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..theme = json['Theme'] == null
          ? null
          : ProductFacetModel.fromJson(json['Theme'] as Map<String, dynamic>)
      ..offerTypesValue = (json['OfferTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..productTheme = json['ProductTheme'] == null
          ? null
          : ProductFacetModel.fromJson(
              json['ProductTheme'] as Map<String, dynamic>)
      ..comment = json['Comment'] == null
          ? null
          : ProductCommentaryModel.fromJson(
              json['Comment'] as Map<String, dynamic>)
      ..categoryId = json['CategoryId'] as int?
      ..stateId = json['StateId'] as int?
      ..estimatedReadTime = json['EstimatedReadTime'] as String?
      ..language = json['Language'] as String?
      ..isAdultContent = json['IsAdultContent'] as bool?
      ..accessTypes =
          (json['AccessTypes'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..isPublic = json['IsPublic'] as bool?
      ..onlineDate = json['OnlineDate'] == null
          ? null
          : DateTime.parse(json['OnlineDate'] as String);

Map<String, dynamic> _$ProductSearchItemOutputModelToJson(
        ProductSearchItemOutputModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Title': instance.title,
      'Description': instance.description,
      'Authors': instance.authors,
      'OwnerUserName': instance.ownerUserName,
      'OwnerDisplayableUserName': instance.ownerDisplayableUserName,
      'NbPages': instance.nbPages,
      'NbReads': instance.nbReads,
      'AvgScore': instance.avgScore,
      'Price': instance.price,
      'NbVotes': instance.nbVotes,
      'PertinenceWeight': instance.pertinenceWeight,
      'Theme': instance.theme,
      'OfferTypes': instance.offerTypesValue,
      'PublicFormatExtensions': instance.publicFormatExtensions,
      'ExtractPublicFormatExtensions': instance.extractPublicFormatExtensions,
      'ThumbnailUrls': instance.thumbnailUrls,
      'Extensions': instance.extensions,
      'ImageUrls': instance.imageUrls,
      'ProductTheme': instance.productTheme,
      'Comment': instance.comment,
      'Category': instance.category,
      'CategoryId': instance.categoryId,
      'StateId': instance.stateId,
      'EstimatedReadTime': instance.estimatedReadTime,
      'Language': instance.language,
      'IsAdultContent': instance.isAdultContent,
      'AccessTypes': instance.accessTypes,
      'IsPublic': instance.isPublic,
      'OnlineDate': instance.onlineDate?.toIso8601String(),
      'Origin': instance.origin,
    };
