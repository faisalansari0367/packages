// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'update_profile_params.g.dart';

@JsonSerializable()
class UpdateProfileParams {
  final String? name;
  final String? email;
  final String? mobile;
  
  UpdateProfileParams({
    this.name,
    this.email,
    this.mobile,
  });

  factory UpdateProfileParams.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileParamsToJson(this);
}
