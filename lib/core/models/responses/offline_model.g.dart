// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfflineModel _$OfflineModelFromJson(Map<String, dynamic> json) => OfflineModel(
      offlinedDate: json['OfflinedDate'] == null
          ? null
          : DateTime.parse(json['OfflinedDate'] as String),
      product: json['Product'] == null
          ? null
          : ProductModel.fromJson(json['Product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfflineModelToJson(OfflineModel instance) =>
    <String, dynamic>{
      'OfflinedDate': instance.offlinedDate?.toIso8601String(),
      'Product': instance.product,
    };
