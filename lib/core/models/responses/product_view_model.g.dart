// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductViewModel _$ProductViewModelFromJson(Map<String, dynamic> json) =>
    ProductViewModel(
      accountId: json['AccountId'] as int?,
      productId: json['ProductId'] as int?,
      trackingId: json['TrackingId'] as String?,
      actionDate: json['ActionDate'] == null
          ? null
          : DateTime.parse(json['ActionDate'] as String),
    );

Map<String, dynamic> _$ProductViewModelToJson(ProductViewModel instance) =>
    <String, dynamic>{
      'AccountId': instance.accountId,
      'ProductId': instance.productId,
      'TrackingId': instance.trackingId,
      'ActionDate': instance.actionDate?.toIso8601String(),
    };
