// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ys_product_get_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YSProductGetModel _$YSProductGetModelFromJson(Map<String, dynamic> json) =>
    YSProductGetModel(
      category: json['Category'] == null
          ? null
          : ProductCategoryModel.fromJson(
              json['Category'] as Map<String, dynamic>),
      id: json['Id'] as int?,
      title: json['Title'] as String?,
      author: json['Author'] as String?,
      description: json['Description'] as String?,
      ownerId: json['OwnerId'] as int?,
      ownerUserName: json['OwnerUserName'] as String?,
      ownerDisplayableUserName: json['OwnerDisplayableUserName'] as String?,
      themeId: json['ThemeId'] as int?,
      categoryId: json['CategoryId'] as int?,
      collectionId: json['CollectionId'] as int?,
      collectionTitle: json['CollectionTitle'] as String?,
      isEditorFollowed: json['IsEditorFollowed'] as bool?,
      isAuthorFollowed: json['IsAuthorFollowed'] as bool?,
      state: json['State'] as String?,
      eAN13: json['EAN13'] as String?,
      source: json['Source'] as String?,
      externalLink: json['ExternalLink'] as String?,
      publicFormatExtensions: (json['PublicFormatExtensions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      defaultRight: json['DefaultRight'] as int?,
      languagesIsoCode: (json['LanguagesIsoCode'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publishDate: json['PublishDate'] == null
          ? null
          : DateTime.parse(json['PublishDate'] as String),
      estimatedReadTime: json['EstimatedReadTime'] as String?,
      licenceName: json['LicenceName'] as String?,
      brandIds:
          (json['BrandIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      isIndexable: json['IsIndexable'] as bool?,
      authorId: json['AuthorId'] as int?,
      comment: json['Comment'] == null
          ? null
          : ProductCommentaryModel.fromJson(
              json['Comment'] as Map<String, dynamic>),
    )
      ..tags = (json['Tags'] as List<dynamic>?)
          ?.map((e) => ProductGetTag.fromJson(e as Map<String, dynamic>))
          .toList()
      ..classifications = (json['Classifications'] as List<dynamic>?)
          ?.map((e) =>
              ProductGetClassification.fromJson(e as Map<String, dynamic>))
          .toList()
      ..thumbnailUrls = (json['ThumbnailUrls'] as List<dynamic>?)
          ?.map((e) => ImageUrlOutput.fromJson(e as Map<String, dynamic>))
          .toList()
      ..offers = (json['Offers'] as List<dynamic>?)
          ?.map((e) => ProductGetOfferModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..distributionInfo = json['DistributionInfo'] == null
          ? null
          : ProductGetDistributionInfo.fromJson(
              json['DistributionInfo'] as Map<String, dynamic>)
      ..document = json['Document'] == null
          ? null
          : ProductGetDocument.fromJson(
              json['Document'] as Map<String, dynamic>)
      ..extractDocument = json['ExtractDocument'] == null
          ? null
          : ProductGetDocument.fromJson(
              json['ExtractDocument'] as Map<String, dynamic>)
      ..audioDocuments = (json['AudioDocuments'] as List<dynamic>?)
          ?.map((e) => ProductGetDocument.fromJson(e as Map<String, dynamic>))
          .toList()
      ..people = (json['People'] as List<dynamic>?)
          ?.map((e) => ProductGetPeople.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$YSProductGetModelToJson(YSProductGetModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Title': instance.title,
      'Author': instance.author,
      'Description': instance.description,
      'OwnerId': instance.ownerId,
      'OwnerUserName': instance.ownerUserName,
      'OwnerDisplayableUserName': instance.ownerDisplayableUserName,
      'ThemeId': instance.themeId,
      'CategoryId': instance.categoryId,
      'CollectionId': instance.collectionId,
      'CollectionTitle': instance.collectionTitle,
      'IsEditorFollowed': instance.isEditorFollowed,
      'IsAuthorFollowed': instance.isAuthorFollowed,
      'State': instance.state,
      'EAN13': instance.eAN13,
      'Source': instance.source,
      'ExternalLink': instance.externalLink,
      'PublicFormatExtensions': instance.publicFormatExtensions,
      'DefaultRight': instance.defaultRight,
      'LanguagesIsoCode': instance.languagesIsoCode,
      'PublishDate': instance.publishDate?.toIso8601String(),
      'EstimatedReadTime': instance.estimatedReadTime,
      'LicenceName': instance.licenceName,
      'BrandIds': instance.brandIds,
      'IsIndexable': instance.isIndexable,
      'AuthorId': instance.authorId,
      'Tags': instance.tags,
      'Classifications': instance.classifications,
      'ThumbnailUrls': instance.thumbnailUrls,
      'Offers': instance.offers,
      'DistributionInfo': instance.distributionInfo,
      'Document': instance.document,
      'ExtractDocument': instance.extractDocument,
      'AudioDocuments': instance.audioDocuments,
      'Category': instance.category,
      'People': instance.people,
      'Comment': instance.comment,
    };
