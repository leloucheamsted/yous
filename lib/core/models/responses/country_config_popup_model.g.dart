// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_config_popup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryConfigPopupModel _$CountryConfigPopupModelFromJson(
        Map<String, dynamic> json) =>
    CountryConfigPopupModel(
      title: json['Title'] as String?,
      topText:
          (json['TopText'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bottomText: (json['BottomText'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      buttons: (json['Buttons'] as List<dynamic>?)
          ?.map((e) => CountryConfigRegisterPopupButtonModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryConfigPopupModelToJson(
        CountryConfigPopupModel instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'TopText': instance.topText,
      'BottomText': instance.bottomText,
      'Buttons': instance.buttons,
    };
