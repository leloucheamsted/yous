import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/country_config_entity.dart';
import 'package:youscribe/core/models/responses/country_config_popup_model.dart';
import 'package:youscribe/core/models/responses/country_config_register_popup_button_model.dart';

part 'country_configuration_entity.g.dart';

@embedded
class CountryConfigurationEntity extends CountryConfigEntity {}

@embedded
class CountryConfigPopupEntity {
  CountryConfigPopupEntity({
    this.title,
    this.topText,
    this.bottomText,
    this.buttons,
  });
  factory CountryConfigPopupEntity.fromModel(CountryConfigPopupModel model) =>
      CountryConfigPopupEntity(
        title: model.title,
        topText: model.topText,
        bottomText: model.bottomText,
        buttons: model.buttons
            ?.map(CountryConfigRegisterPopupButtonEntity.fromModel)
            .toList(),
      );
  String? title;
  List<String>? topText;
  List<String>? bottomText;
  List<CountryConfigRegisterPopupButtonEntity>? buttons;
}

@embedded
class CountryConfigRegisterPopupButtonEntity {
  CountryConfigRegisterPopupButtonEntity({
    this.text,
    this.smsPhoneNumber,
    this.smsCode,
  });

  factory CountryConfigRegisterPopupButtonEntity.fromModel(
          CountryConfigRegisterPopupButtonModel model) =>
      CountryConfigRegisterPopupButtonEntity(
        text: model.text,
        smsPhoneNumber: model.smsPhoneNumber,
        smsCode: model.smsCode,
      );

  String? text;
  String? smsPhoneNumber;
  String? smsCode;
}
