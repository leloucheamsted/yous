// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_get_offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductGetOfferModel _$ProductGetOfferModelFromJson(
        Map<String, dynamic> json) =>
    ProductGetOfferModel(
      id: json['Id'] as int?,
      offerTypeName: json['OfferTypeName'] as String?,
      allowStreaming: json['AllowStreaming'] as bool?,
      allowDownload: json['AllowDownload'] as bool?,
      price: (json['Price'] as num?)?.toDouble(),
      currency: json['Currency'] as String?,
      priceTaxIncluded: json['PriceTaxIncluded'] as bool?,
      taxRate: (json['TaxRate'] as num?)?.toDouble(),
      maxDeviceUse: json['MaxDeviceUse'] as int?,
      maxDayUse: json['MaxDayUse'] as int?,
      maxTimeUse: json['MaxTimeUse'] as int?,
    );

Map<String, dynamic> _$ProductGetOfferModelToJson(
        ProductGetOfferModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'OfferTypeName': instance.offerTypeName,
      'AllowStreaming': instance.allowStreaming,
      'AllowDownload': instance.allowDownload,
      'Price': instance.price,
      'Currency': instance.currency,
      'PriceTaxIncluded': instance.priceTaxIncluded,
      'TaxRate': instance.taxRate,
      'MaxDeviceUse': instance.maxDeviceUse,
      'MaxDayUse': instance.maxDayUse,
      'MaxTimeUse': instance.maxTimeUse,
    };
