import 'package:json_annotation/json_annotation.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/models/responses/image_url_output.dart';
import 'package:youscribe/core/models/responses/product_category_model.dart';
import 'package:youscribe/core/models/responses/product_commentary_model.dart';
import 'package:youscribe/core/models/responses/product_facet_model.dart';
import 'package:youscribe/core/models/responses/product_model.dart';
import 'package:youscribe/core/models/responses/product_offer_type.dart';
import 'package:youscribe/core/models/utilities.dart';
part 'product_search_item_output_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductSearchItemOutputModel {
  ProductSearchItemOutputModel({
    this.id,
    this.origin,
    this.category,
    this.title,
    this.description,
    this.authors,
    this.ownerUserName,
    this.ownerDisplayableUserName,
    this.nbPages,
    this.nbReads,
    this.avgScore,
    this.price,
    this.nbVotes,
    this.pertinenceWeight,
    this.publicFormatExtensions,
    this.extractPublicFormatExtensions,
    this.thumbnailUrls,
    this.extensions,
    this.imageUrls,
  });
  factory ProductSearchItemOutputModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchItemOutputModelFromJson(json);
  int? id;
  String? title;
  String? description;
  List<String>? authors;
  String? ownerUserName;
  String? ownerDisplayableUserName;
  int? nbPages;
  int? nbReads;
  double? avgScore;
  double? price;
  int? nbVotes;
  double? pertinenceWeight;
  ProductFacetModel? theme;
  @JsonKey(includeFromJson: false)
  List<ProductOfferType>? get offerTypes => offerTypesValue.isNotNullOrEmpty
      ? offerTypesValue!.map(ProductModel.parseOffer).toList()
      : [];

  @JsonKey(name: 'OfferTypes')
  List<String>? offerTypesValue;

  List<String>? publicFormatExtensions;
  List<String>? extractPublicFormatExtensions;
  List<ImageUrlOutput>? thumbnailUrls;
  List<String>? extensions;
  List<ImageUrlOutput>? imageUrls;
  ProductFacetModel? productTheme;
  ProductCommentaryModel? comment;
  ProductCategoryModel? category;
  int? categoryId; // This property is used when Category is not set
  int? stateId;
  String? estimatedReadTime;
  Duration get estimatedReadTimeInDuration =>
      convertStringTimeSpanToDuration(estimatedReadTime ?? "");
  String? language;
  bool? isAdultContent;
  List<int>? accessTypes;
  bool? isPublic;
  DateTime? onlineDate;
  String? origin;

  Map<String, dynamic> toJson() {
    return _$ProductSearchItemOutputModelToJson(this);
  }
}
