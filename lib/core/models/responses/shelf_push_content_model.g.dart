// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_push_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShelfPushContentModel _$ShelfPushContentModelFromJson(
        Map<String, dynamic> json) =>
    ShelfPushContentModel(
      id: json['Id'] as String?,
      selectionUrl: json['SelectionUrl'] as String?,
      order: json['Order'] as int?,
      title: json['Title'] as String?,
      totalCount: json['TotalCount'] as int?,
      products: (json['Products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShelfPushContentModelToJson(
        ShelfPushContentModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'SelectionUrl': instance.selectionUrl,
      'Order': instance.order,
      'Title': instance.title,
      'TotalCount': instance.totalCount,
      'Products': instance.products,
    };
