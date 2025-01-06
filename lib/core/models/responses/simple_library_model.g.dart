// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_library_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleLibraryModel _$SimpleLibraryModelFromJson(Map<String, dynamic> json) =>
    SimpleLibraryModel(
      isPublic: json['IsPublic'] as bool?,
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      label: json['Label'] as String?,
      typeName: json['TypeName'] as String?,
      accountId: json['AccountId'] as int?,
      productPublicCount: json['ProductPublicCount'] as int?,
      productPrivateCount: json['ProductPrivateCount'] as int?,
      lastProduct: json['LastProduct'] == null
          ? null
          : LibraryProductModel.fromJson(
              json['LastProduct'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SimpleLibraryModelToJson(SimpleLibraryModel instance) =>
    <String, dynamic>{
      'IsPublic': instance.isPublic,
      'Id': instance.id,
      'Name': instance.name,
      'Label': instance.label,
      'TypeName': instance.typeName,
      'AccountId': instance.accountId,
      'ProductPublicCount': instance.productPublicCount,
      'ProductPrivateCount': instance.productPrivateCount,
      'LastProduct': instance.lastProduct,
    };
