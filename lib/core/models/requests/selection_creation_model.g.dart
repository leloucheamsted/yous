// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection_creation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectionCreationModel _$SelectionCreationModelFromJson(
        Map<String, dynamic> json) =>
    SelectionCreationModel(
      libraryName: json['LibraryName'] as String?,
      isPublic: json['IsPublic'] as String?,
    );

Map<String, dynamic> _$SelectionCreationModelToJson(
        SelectionCreationModel instance) =>
    <String, dynamic>{
      'LibraryName': instance.libraryName,
      'IsPublic': instance.isPublic,
    };
