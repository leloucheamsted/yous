// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageModel _$LanguageModelFromJson(Map<String, dynamic> json) =>
    LanguageModel(
      name: json['Name'] as String?,
      id: json['Id'] as int?,
    )..label = json['Label'] as String?;

Map<String, dynamic> _$LanguageModelToJson(LanguageModel instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Id': instance.id,
      'Label': instance.label,
    };
