// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editorial_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditorialModel _$EditorialModelFromJson(Map<String, dynamic> json) =>
    EditorialModel(
      typeId: json['TypeId'] as int?,
      firstImage: json['FirstImage'] as String?,
      secondImage: json['SecondImage'] as String?,
      backgroundImage: json['BackgroundImage'] as String?,
      firstLink: json['FirstLink'] as String?,
      secondLink: json['SecondLink'] as String?,
      order: json['Order'] as int?,
    );

Map<String, dynamic> _$EditorialModelToJson(EditorialModel instance) =>
    <String, dynamic>{
      'TypeId': instance.typeId,
      'FirstImage': instance.firstImage,
      'SecondImage': instance.secondImage,
      'BackgroundImage': instance.backgroundImage,
      'FirstLink': instance.firstLink,
      'SecondLink': instance.secondLink,
      'Order': instance.order,
    };
