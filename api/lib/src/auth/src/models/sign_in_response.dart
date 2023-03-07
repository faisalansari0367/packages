import 'package:json_annotation/json_annotation.dart';

part'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponse {
  int? status;
  int? balancePoints;
  String? token;
  String? message;

  SignInResponse({
    this.status,
    this.balancePoints,
    this.token,
    this.message,
  });


  factory SignInResponse.fromJson(Map<String, dynamic> json) => _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);

}
