// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_facet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductFacetModel _$ProductFacetModelFromJson(Map<String, dynamic> json) =>
    ProductFacetModel(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      label: json['Label'] as String?,
      parent: json['Parent'] == null
          ? null
          : ProductFacetModel.fromJson(json['Parent'] as Map<String, dynamic>),
      count: json['Count'] as int?,
      mobileIconUrl: json['MobileIconUrl'] as String?,
      children: (json['Children'] as List<dynamic>?)
              ?.map(
                  (e) => ProductFacetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    )..children2 = (json['Childs'] as List<dynamic>?)
        ?.map((e) => ProductFacetModel.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ProductFacetModelToJson(ProductFacetModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Label': instance.label,
      'Count': instance.count,
      'MobileIconUrl': instance.mobileIconUrl,
      'Parent': instance.parent,
      'Children': instance.children,
      'Childs': instance.children2,
    };
