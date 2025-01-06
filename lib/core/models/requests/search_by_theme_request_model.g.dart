// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_by_theme_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSearchByThemeInputModel _$ProductSearchByThemeInputModelFromJson(
        Map<String, dynamic> json) =>
    ProductSearchByThemeInputModel(
      parentsClassificationId:
          (json['parents_classification_id'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),
      childrenClassificationId:
          (json['children_classification_id'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),
      themeIds:
          (json['theme_Ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
    )
      ..authorId = json['author_id'] as int?
      ..id = (json['id'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..collectionId = json['collection_id'] as int?
      ..themeId = json['theme_id'] as int?
      ..categoryId = json['category_id'] as int?
      ..quicksearch = json['quicksearch'] as String?
      ..author = json['author'] as String?
      ..offerType = (json['offer_type'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..excludedOfferType = (json['excluded_offer_type'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..title = json['title'] as String?
      ..domainLanguage = json['domain_language'] as String?
      ..isAdultContent = json['is_adult_content'] as bool?
      ..skip = json['skip'] as int?
      ..setLng = json['setLng'] as String?
      ..take = json['take'] as int?
      ..sort =
          (json['sort'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..languageId = json['language_id'] as int?
      ..priceGroup = json['price_group'] as int?
      ..accessType = json['access_type'] as int?
      ..excludedThemeId = (json['excluded_theme_id'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList()
      ..excludedCategoryId = (json['excluded_category_id'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList()
      ..requestedFacet = (json['requested_facet'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..publicFormatExtension =
          (json['public_format_extension'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList()
      ..nbPagesMin = json['nb_pages_min'] as int?
      ..nbPagesMax = json['nb_pages_max'] as int?
      ..tagId = json['tag_id'] as int?
      ..inTagsId =
          (json['in_tags_id'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..tagsId =
          (json['tags_id'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..sensibilityId = (json['sensibility_id'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList()
      ..rubricId =
          (json['rubric_id'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..inOwnerId =
          (json['in_owner_id'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..ownerId = json['owner_Id'] as int?
      ..isSearchable =
          $enumDecodeNullable(_$SearchableFlagEnumMap, json['is_searchable'])
      ..isPublic =
          $enumDecodeNullable(_$VisibilityFlagEnumMap, json['is_public'])
      ..includePremium = $enumDecodeNullable(
          _$SearchPremiumFlagEnumMap, json['include_premium'])
      ..stateId =
          (json['state_id'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..excludedLanguageId = (json['excluded_language_id'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList()
      ..isFree = json['is_free'] as bool?
      ..creationDateMin = json['creation_date_min'] == null
          ? null
          : DateTime.parse(json['creation_date_min'] as String)
      ..creationDateMax = json['creation_date_max'] == null
          ? null
          : DateTime.parse(json['creation_date_max'] as String)
      ..updateDateMin = json['update_date_min'] == null
          ? null
          : DateTime.parse(json['update_date_min'] as String)
      ..updateDateMax = json['update_date_max'] == null
          ? null
          : DateTime.parse(json['update_date_max'] as String)
      ..disabledDateMin = json['disabled_date_min'] == null
          ? null
          : DateTime.parse(json['disabled_date_min'] as String)
      ..disabledDateMax = json['disabled_date_max'] == null
          ? null
          : DateTime.parse(json['disabled_date_max'] as String)
      ..excludedProductId = (json['excluded_product_id'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList()
      ..classificationId = json['classification_id'] as int?
      ..inClassificationId = (json['in_classification_id'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList()
      ..allClassificationId = (json['all_classification_id'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList();

Map<String, dynamic> _$ProductSearchByThemeInputModelToJson(
        ProductSearchByThemeInputModel instance) =>
    <String, dynamic>{
      'author_id': instance.authorId,
      'id': instance.id,
      'collection_id': instance.collectionId,
      'theme_id': instance.themeId,
      'category_id': instance.categoryId,
      'quicksearch': instance.quicksearch,
      'author': instance.author,
      'offer_type': instance.offerType,
      'excluded_offer_type': instance.excludedOfferType,
      'title': instance.title,
      'domain_language': instance.domainLanguage,
      'is_adult_content': instance.isAdultContent,
      'skip': instance.skip,
      'setLng': instance.setLng,
      'take': instance.take,
      'sort': instance.sort,
      'language_id': instance.languageId,
      'price_group': instance.priceGroup,
      'access_type': instance.accessType,
      'excluded_theme_id': instance.excludedThemeId,
      'excluded_category_id': instance.excludedCategoryId,
      'requested_facet': instance.requestedFacet,
      'public_format_extension': instance.publicFormatExtension,
      'nb_pages_min': instance.nbPagesMin,
      'nb_pages_max': instance.nbPagesMax,
      'tag_id': instance.tagId,
      'in_tags_id': instance.inTagsId,
      'tags_id': instance.tagsId,
      'sensibility_id': instance.sensibilityId,
      'rubric_id': instance.rubricId,
      'in_owner_id': instance.inOwnerId,
      'owner_Id': instance.ownerId,
      'is_searchable': _$SearchableFlagEnumMap[instance.isSearchable],
      'is_public': _$VisibilityFlagEnumMap[instance.isPublic],
      'include_premium': _$SearchPremiumFlagEnumMap[instance.includePremium],
      'state_id': instance.stateId,
      'excluded_language_id': instance.excludedLanguageId,
      'is_free': instance.isFree,
      'creation_date_min': instance.creationDateMin?.toIso8601String(),
      'creation_date_max': instance.creationDateMax?.toIso8601String(),
      'update_date_min': instance.updateDateMin?.toIso8601String(),
      'update_date_max': instance.updateDateMax?.toIso8601String(),
      'disabled_date_min': instance.disabledDateMin?.toIso8601String(),
      'disabled_date_max': instance.disabledDateMax?.toIso8601String(),
      'excluded_product_id': instance.excludedProductId,
      'classification_id': instance.classificationId,
      'in_classification_id': instance.inClassificationId,
      'all_classification_id': instance.allClassificationId,
      'parents_classification_id': instance.parentsClassificationId,
      'children_classification_id': instance.childrenClassificationId,
      'theme_Ids': instance.themeIds,
    };

const _$SearchableFlagEnumMap = {
  SearchableFlag.searchable: 'searchable',
  SearchableFlag.notSearchable: 'notSearchable',
  SearchableFlag.all: 'all',
};

const _$VisibilityFlagEnumMap = {
  VisibilityFlag.public: 'public',
  VisibilityFlag.private: 'private',
  VisibilityFlag.all: 'all',
};

const _$SearchPremiumFlagEnumMap = {
  SearchPremiumFlag.yes: 'yes',
  SearchPremiumFlag.no: 'no',
  SearchPremiumFlag.only: 'only',
};
