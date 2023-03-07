// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'sign_up_model.g.dart';

@JsonSerializable()
class SignUpModel {
  @JsonKey(name: 'name')
  String? fullName;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'mobile')
  int? phoneNumber;

  String? password;

  @JsonKey(name: 'password_confirmation')
  String? confirmPassword;
  // String? countryCode;

  SignUpModel({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.password,
    this.confirmPassword,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}
