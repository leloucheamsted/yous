import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/image_url_output.dart';
import 'package:youscribe/core/models/responses/product_category_model.dart';
import 'package:youscribe/core/models/responses/product_commentary_model.dart';
import 'package:youscribe/core/models/responses/product_get_classification.dart';
import 'package:youscribe/core/models/responses/product_get_distribution_info.dart';
import 'package:youscribe/core/models/responses/product_get_document.dart';
import 'package:youscribe/core/models/responses/product_get_offer_model.dart';
import 'package:youscribe/core/models/responses/product_get_people.dart';
import 'package:youscribe/core/models/responses/product_get_tag.dart';
import 'package:youscribe/core/models/utilities.dart';
part 'ys_product_get_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class YSProductGetModel {
  YSProductGetModel({
    this.category,
    this.id,
    this.title,
    this.author,
    this.description,
    this.ownerId,
    this.ownerUserName,
    this.ownerDisplayableUserName,
    this.themeId,
    this.categoryId,
    this.collectionId,
    this.collectionTitle,
    this.isEditorFollowed,
    this.isAuthorFollowed,
    this.state,
    this.eAN13,
    this.source,
    this.externalLink,
    this.publicFormatExtensions,
    this.defaultRight,
    this.languagesIsoCode,
    this.publishDate,
    this.estimatedReadTime,
    this.licenceName,
    this.brandIds,
    this.isIndexable,
    this.authorId,
    this.comment,
  });
  factory YSProductGetModel.fromJson(Map<String, dynamic> json) =>
      _$YSProductGetModelFromJson(json);

  int? id;
  String? title;
  String? author;
  String? description;
  int? ownerId;
  String? ownerUserName;
  String? ownerDisplayableUserName;
  int? themeId;
  int? categoryId;
  int? collectionId;
  String? collectionTitle;
  bool? isEditorFollowed;
  bool? isAuthorFollowed;
  String? state;
  String? eAN13;
  String? source;
  String? externalLink;
  List<String>? publicFormatExtensions;
  int? defaultRight;
  List<String>? languagesIsoCode;
  DateTime? publishDate;
  String? estimatedReadTime;
  String? licenceName;
  List<int>? brandIds;
  bool? isIndexable;
  int? authorId;
  List<ProductGetTag>? tags;
  List<ProductGetClassification>? classifications;
  List<ImageUrlOutput>? thumbnailUrls;
  List<ProductGetOfferModel>? offers;
  ProductGetDistributionInfo? distributionInfo;
  ProductGetDocument? document;
  ProductGetDocument? extractDocument;
  List<ProductGetDocument>? audioDocuments;
  ProductCategoryModel? category;
  List<ProductGetPeople>? people;
  ProductCommentaryModel? comment;

  Duration get estimatedReadTimeInDuration =>
      convertStringTimeSpanToDuration(estimatedReadTime ?? "");

  String toJson() {
    final map = _$YSProductGetModelToJson(this);
    return jsonEncode(map);
  }
}

enum OpinionSource {
  @JsonValue("None")
  none,
  @JsonValue("YSTeam")
  ysTeam,
  @JsonValue("Author")
  author,
  @JsonValue("Ambassador")
  ambassador
}
