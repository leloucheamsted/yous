import 'package:json_annotation/json_annotation.dart';
part 'account_device_local_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountDeviceLocalModel {
  AccountDeviceLocalModel({
    required this.id,
    required this.deviceId,
    required this.deviceTypeName,
    required this.os,
    required this.osVersion,
    required this.lastSeen,
    required this.label,
    required this.modelName,
  });
  factory AccountDeviceLocalModel.fromJson(Map<String, dynamic> json) =>
      _$AccountDeviceLocalModelFromJson(json);
  int? id;
  String? deviceId;
  String? deviceTypeName;
  String? os;
  String? osVersion;
  DateTime? lastSeen;
  String? label;
  String? modelName;

  Map<String, dynamic> toJson() {
    return _$AccountDeviceLocalModelToJson(this);
  }
}
