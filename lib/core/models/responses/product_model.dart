import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/audio_chapter_model.dart';
import 'package:youscribe/core/models/responses/product_commentary_model.dart';
import 'package:youscribe/core/models/responses/product_get_document.dart';
import 'package:youscribe/core/models/responses/product_get_people.dart';
import 'package:youscribe/core/models/responses/product_get_tag.dart';
import 'package:youscribe/core/models/responses/product_offer_model.dart';
import 'package:youscribe/core/models/responses/product_offer_type.dart';
import 'package:youscribe/core/models/responses/thumbnail_model.dart';
import 'package:youscribe/core/models/responses/ys_product_get_model.dart';
import 'package:youscribe/core/models/utilities.dart';
part 'product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductModel {
  ProductModel({
    this.imageUrls,
    this.playlistModel,
    this.people,
    this.tags,
    this.offers,
    this.id,
    this.title,
    this.description,
    this.author,
    this.narrator,
    this.isFavorite,
    this.isOffline,
    this.languagesIsoCode,
    this.extensions,
    this.right,
    this.estimatedReadTime,
    this.ownerDisplayableUserName,
    this.ownerUserName,
    this.ownerId,
    this.rentalPriceByPages,
    this.categoryId,
    this.themeId,
    this.rootThemeId,
    this.documentProtectionTypeName,
    this.voteEligibility,
    this.voteValue,
    this.voteCampainLabel,
    this.totalDuration,
    this.nbParts,
    this.numberOfPages,
    this.classificationsIds,
    this.publishDate,
    this.origin,
    this.authorId,
    this.collectionId,
    this.collectionTitle,
    this.isEditorFollowed,
    this.isAuthorFollowed,
    this.document,
    this.comment,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  int? id;
  String? title;
  String? description;
  String? author;
  String? narrator;
  bool? isFavorite;
  bool? isOffline;
  List<String>? languagesIsoCode;
  List<String?>? extensions;
  int? right;
  String? estimatedReadTime;
  Duration get estimatedReadTimeInDuration =>
      convertStringTimeSpanToDuration(estimatedReadTime ?? "");

  String? ownerDisplayableUserName;
  String? ownerUserName;
  int? ownerId;
  double? rentalPriceByPages;
  int? categoryId;
  int? themeId;
  int? rootThemeId;
  String? documentProtectionTypeName;
  bool? voteEligibility;
  int? voteValue;
  String? voteCampainLabel;
  double? totalDuration;
  int? nbParts;
  int? numberOfPages;
  List<int?>? classificationsIds;
  DateTime? publishDate;
  String? origin;
  int? authorId;
  int? collectionId;
  String? collectionTitle;
  bool? isEditorFollowed;
  bool? isAuthorFollowed;
  List<ProductGetPeople>? people;
  ProductGetDocument? document;
  List<ProductGetTag>? tags;
  List<AudioChapterModel>? playlistModel;
  List<ProductOfferModel>? offers;
  List<ThumbnailModel>? imageUrls;
  ProductCommentaryModel? comment;

  static List<ProductOfferModel> parseOffers(List<String?>? offers) {
    if (offers == null || !offers.any((element) => true)) {
      return [ProductOfferModel(ProductOfferType.subscription)];
    }

    for (int i = 0; i < offers.length; i++) {
      switch (offers[i]) {
        case "Buyable":
        case "Buy":
          return [ProductOfferModel(ProductOfferType.buy)];
        case "Free":
          return [ProductOfferModel(ProductOfferType.free)];
        case "Subscription":
          return [ProductOfferModel(ProductOfferType.subscription)];
        case "Premium":
          return [ProductOfferModel(ProductOfferType.premium)];
      }
    }

    return [ProductOfferModel(ProductOfferType.subscription)];
  }

  static ProductOfferType parseOffer(String offer) {
    switch (offer) {
      case "Buyable":
      case "Buy":
        return ProductOfferType.buy;
      case "Free":
        return ProductOfferType.free;
      case "Subscription":
        return ProductOfferType.subscription;
      case "Premium":
        return ProductOfferType.premium;
    }

    return ProductOfferType.subscription;
  }

  static String getNarrator(List<ProductGetPeople>? peoples) {
    if (peoples != null && peoples.isNotEmpty) {
      final narrators = peoples.where((x) => x.function == "narrator");

      if (narrators.isNotEmpty) {
        final narrator = narrators.first;
        return "${narrator.firstName} ${narrator.lastName}".trim();
      }
    }
    return '';
  }

  static int getAuthorId(List<ProductGetPeople>? peoples) {
    if (peoples != null &&
        peoples.any((element) => element.function == "author")) {
      final author = peoples.where((x) => x.function == "author").first;
      return author.id ?? 0;
    }

    return 0;
  }

  // ignore: prefer_constructors_over_static_methods
  static ProductModel from(YSProductGetModel model) {
    // To-do: Set LanguagesIsoCode on product model
    final productModel = ProductModel(
      isEditorFollowed: model.isEditorFollowed,
      isAuthorFollowed: model.isAuthorFollowed,
      id: model.id,
      tags: model.tags,
      numberOfPages: model.document?.nbPages ?? 0,
      description: model.description,
      title: model.title,
      document: model.document,
      author: model.author,
      extensions: model.document?.formats?.map((d) => d.extension).toList() ??
          model.publicFormatExtensions,
      imageUrls: model.thumbnailUrls
          ?.map(
            (i) => ThumbnailModel(
              height: i.height,
              url: i.url,
              width: i.width,
            ),
          )
          .toList(),
      offers: model.offers == null
          ? <ProductOfferModel>[]
          : parseOffers(model.offers?.map((o) => o.offerTypeName).toList())
              .toList(),
      collectionId: model.collectionId,
      collectionTitle: model.collectionTitle,
      languagesIsoCode: model.languagesIsoCode,
      estimatedReadTime: model.estimatedReadTime,
      ownerUserName: model.ownerUserName,
      ownerDisplayableUserName: model.ownerDisplayableUserName,
      themeId: model.themeId,
      categoryId: model.categoryId,
      comment: model.comment,
      documentProtectionTypeName: model.document?.documentProtectionTypeName,
      voteEligibility: false,
      voteValue: 0,
      nbParts: 200,
      narrator: getNarrator(model.people),
      ownerId: model.ownerId,
      classificationsIds: model.classifications?.map((s) => s.id).toList(),
      authorId: getAuthorId(model.people),
    );

    if (productModel.categoryId == null || productModel.categoryId == 0) {
      productModel.categoryId = model.category?.id;
    }

    return productModel;
  }

  String toJson() {
    final map = _$ProductModelToJson(this);
    return jsonEncode(map);
  }
}
