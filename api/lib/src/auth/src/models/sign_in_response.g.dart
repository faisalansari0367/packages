// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      status: json['status'] as int?,
      balancePoints: json['balancePoints'] as int?,
      token: json['token'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'balancePoints': instance.balancePoints,
      'token': instance.token,
      'message': instance.message,
    };
