import 'package:json_annotation/json_annotation.dart';

part 'requests.g.dart';

@JsonSerializable()
class LoginRequest {
  final String identifier;
  final String password;
  final String organizationId;

  LoginRequest(this.identifier, this.password, this.organizationId);

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
