// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_views_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastViewsModel _$LastViewsModelFromJson(Map<String, dynamic> json) =>
    LastViewsModel(
      viewDate: json['ViewDate'] == null
          ? null
          : DateTime.parse(json['ViewDate'] as String),
      product: json['Product'] == null
          ? null
          : ProductModel.fromJson(json['Product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LastViewsModelToJson(LastViewsModel instance) =>
    <String, dynamic>{
      'ViewDate': instance.viewDate?.toIso8601String(),
      'Product': instance.product,
    };
