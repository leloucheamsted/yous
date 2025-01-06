// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOfferModel _$ProductOfferModelFromJson(Map<String, dynamic> json) =>
    ProductOfferModel(
      $enumDecodeNullable(_$ProductOfferTypeEnumMap, json['Type']),
    );

Map<String, dynamic> _$ProductOfferModelToJson(ProductOfferModel instance) =>
    <String, dynamic>{
      'Type': _$ProductOfferTypeEnumMap[instance.type],
    };

const _$ProductOfferTypeEnumMap = {
  ProductOfferType.free: 0,
  ProductOfferType.buy: 1,
  ProductOfferType.subscription: 2,
  ProductOfferType.printOnDemand: 4,
  ProductOfferType.premium: 8,
};
