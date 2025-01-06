// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_search_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSearchParameters _$ProductSearchParametersFromJson(
        Map<String, dynamic> json) =>
    ProductSearchParameters()
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

Map<String, dynamic> _$ProductSearchParametersToJson(
    ProductSearchParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('author_id', instance.authorId);
  writeNotNull('id', instance.id);
  writeNotNull('collection_id', instance.collectionId);
  writeNotNull('theme_id', instance.themeId);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('quicksearch', instance.quicksearch);
  writeNotNull('author', instance.author);
  writeNotNull('offer_type', instance.offerType);
  writeNotNull('excluded_offer_type', instance.excludedOfferType);
  writeNotNull('title', instance.title);
  writeNotNull('domain_language', instance.domainLanguage);
  writeNotNull('is_adult_content', instance.isAdultContent);
  writeNotNull('skip', instance.skip);
  writeNotNull('setLng', instance.setLng);
  writeNotNull('take', instance.take);
  writeNotNull('sort', instance.sort);
  writeNotNull('language_id', instance.languageId);
  writeNotNull('price_group', instance.priceGroup);
  writeNotNull('access_type', instance.accessType);
  writeNotNull('excluded_theme_id', instance.excludedThemeId);
  writeNotNull('excluded_category_id', instance.excludedCategoryId);
  writeNotNull('requested_facet', instance.requestedFacet);
  writeNotNull('public_format_extension', instance.publicFormatExtension);
  writeNotNull('nb_pages_min', instance.nbPagesMin);
  writeNotNull('nb_pages_max', instance.nbPagesMax);
  writeNotNull('tag_id', instance.tagId);
  writeNotNull('in_tags_id', instance.inTagsId);
  writeNotNull('tags_id', instance.tagsId);
  writeNotNull('sensibility_id', instance.sensibilityId);
  writeNotNull('rubric_id', instance.rubricId);
  writeNotNull('in_owner_id', instance.inOwnerId);
  writeNotNull('owner_Id', instance.ownerId);
  writeNotNull('is_searchable', _$SearchableFlagEnumMap[instance.isSearchable]);
  writeNotNull('is_public', _$VisibilityFlagEnumMap[instance.isPublic]);
  writeNotNull(
      'include_premium', _$SearchPremiumFlagEnumMap[instance.includePremium]);
  writeNotNull('state_id', instance.stateId);
  writeNotNull('excluded_language_id', instance.excludedLanguageId);
  writeNotNull('is_free', instance.isFree);
  writeNotNull(
      'creation_date_min', instance.creationDateMin?.toIso8601String());
  writeNotNull(
      'creation_date_max', instance.creationDateMax?.toIso8601String());
  writeNotNull('update_date_min', instance.updateDateMin?.toIso8601String());
  writeNotNull('update_date_max', instance.updateDateMax?.toIso8601String());
  writeNotNull(
      'disabled_date_min', instance.disabledDateMin?.toIso8601String());
  writeNotNull(
      'disabled_date_max', instance.disabledDateMax?.toIso8601String());
  writeNotNull('excluded_product_id', instance.excludedProductId);
  writeNotNull('classification_id', instance.classificationId);
  writeNotNull('in_classification_id', instance.inClassificationId);
  writeNotNull('all_classification_id', instance.allClassificationId);
  return val;
}

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
