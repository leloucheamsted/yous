// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_get_people.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductGetPeople _$ProductGetPeopleFromJson(Map<String, dynamic> json) =>
    ProductGetPeople(
      json['FirstName'] as String?,
      json['LastName'] as String?,
      json['Function'] as String?,
      json['Id'] as int?,
    );

Map<String, dynamic> _$ProductGetPeopleToJson(ProductGetPeople instance) =>
    <String, dynamic>{
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'Function': instance.function,
      'Id': instance.id,
    };
