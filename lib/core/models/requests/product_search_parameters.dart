import 'package:json_annotation/json_annotation.dart';
part 'product_search_parameters.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, includeIfNull: false)
class ProductSearchParameters {
  ProductSearchParameters() {
    excludedThemeId = [];
  }
  factory ProductSearchParameters.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchParametersFromJson(json);
  @JsonKey(name: 'author_id')
  int? authorId;
  @JsonKey(name: 'id')
  List<int>? id;
  @JsonKey(name: 'collection_id')
  int? collectionId;
  @JsonKey(name: 'theme_id')
  int? themeId;
  @JsonKey(name: 'category_id')
  int? categoryId;
  @JsonKey(name: 'quicksearch')
  String? quicksearch;
  @JsonKey(name: 'author')
  String? author;
  @JsonKey(name: 'offer_type')
  List<String>? offerType;
  @JsonKey(name: 'excluded_offer_type')
  List<String>? excludedOfferType;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'domain_language')
  String? domainLanguage;
  @JsonKey(name: 'is_adult_content')
  bool? isAdultContent;
  @JsonKey(name: 'skip')
  int? skip;
  @JsonKey(name: 'setLng')
  String? setLng;
  @JsonKey(name: 'take')
  int? take;
  @JsonKey(name: 'sort')
  List<String>? sort;
  @JsonKey(name: 'language_id')
  int? languageId;
  @JsonKey(name: 'price_group')
  int? priceGroup;
  @JsonKey(name: 'access_type')
  int? accessType;
  @JsonKey(name: 'excluded_theme_id')
  List<int>? excludedThemeId;
  @JsonKey(name: 'excluded_category_id')
  List<int>? excludedCategoryId;
  @JsonKey(name: 'requested_facet')
  List<String>? requestedFacet;
  @JsonKey(name: 'public_format_extension')
  List<String>? publicFormatExtension;
  @JsonKey(name: 'nb_pages_min')
  int? nbPagesMin;
  @JsonKey(name: 'nb_pages_max')
  int? nbPagesMax;
  @JsonKey(name: 'tag_id')
  int? tagId;
  @JsonKey(name: 'in_tags_id')
  List<int>? inTagsId;
  @JsonKey(name: 'tags_id')
  List<int>? tagsId;
  @JsonKey(name: 'sensibility_id')
  List<int>? sensibilityId;
  @JsonKey(name: 'rubric_id')
  List<int>? rubricId;
  @JsonKey(name: 'in_owner_id')
  List<int>? inOwnerId;
  @JsonKey(name: 'owner_Id')
  int? ownerId;
  @JsonKey(name: 'is_searchable')
  SearchableFlag? isSearchable;
  @JsonKey(name: 'is_public')
  VisibilityFlag? isPublic;
  @JsonKey(name: 'include_premium')
  SearchPremiumFlag? includePremium;
  @JsonKey(name: 'state_id')
  List<int>? stateId;
  @JsonKey(name: 'excluded_language_id')
  List<int>? excludedLanguageId;
  @JsonKey(name: 'is_free')
  bool? isFree;
  @JsonKey(name: 'creation_date_min')
  DateTime? creationDateMin;
  @JsonKey(name: 'creation_date_max')
  DateTime? creationDateMax;
  @JsonKey(name: 'update_date_min')
  DateTime? updateDateMin;
  @JsonKey(name: 'update_date_max')
  DateTime? updateDateMax;
  @JsonKey(name: 'disabled_date_min')
  DateTime? disabledDateMin;
  @JsonKey(name: 'disabled_date_max')
  DateTime? disabledDateMax;
  @JsonKey(name: 'excluded_product_id')
  List<int>? excludedProductId;
  @JsonKey(name: 'classification_id')
  int? classificationId;
  @JsonKey(name: 'in_classification_id')
  List<int>? inClassificationId;
  @JsonKey(name: 'all_classification_id')
  List<int>? allClassificationId;

  Map<String, dynamic> toJson() {
    return _$ProductSearchParametersToJson(this);
  }
}

enum VisibilityFlag { public, private, all }

enum SearchableFlag { searchable, notSearchable, all }

enum SearchPremiumFlag {
  yes(0),
  no(1),
  only(2);

  const SearchPremiumFlag(this.value);
  final int value;
}
