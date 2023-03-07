// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      fullName: json['name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['mobile'] as int?,
      password: json['password'] as String?,
      confirmPassword: json['password_confirmation'] as String?,
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'name': instance.fullName,
      'email': instance.email,
      'mobile': instance.phoneNumber,
      'password': instance.password,
      'password_confirmation': instance.confirmPassword,
    };
