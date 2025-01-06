// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_search_output_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleSearchOutputItemModel _$PeopleSearchOutputItemModelFromJson(
        Map<String, dynamic> json) =>
    PeopleSearchOutputItemModel(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      pertinenceWeight: (json['PertinenceWeight'] as num?)?.toDouble(),
      thumbnails: (json['Thumbnails'] as List<dynamic>?)
          ?.map((e) => ThumbnailOutputModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PeopleSearchOutputItemModelToJson(
        PeopleSearchOutputItemModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'PertinenceWeight': instance.pertinenceWeight,
      'Thumbnails': instance.thumbnails,
    };
