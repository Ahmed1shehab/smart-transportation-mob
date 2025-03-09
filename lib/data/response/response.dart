import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

//Sign In Response
@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'access_token')
  final String? accessToken;

  DataResponse({this.accessToken});

  factory DataResponse.fromJson(Map<String, dynamic> json) => _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}

@JsonSerializable()
class AuthenticationSignInResponse extends BaseResponse {
  @JsonKey(name: 'data')
  DataResponse? data;

  @JsonKey(name: 'timestamp')
  String timestamp;

  @JsonKey(name: 'path')
  String? path;

  AuthenticationSignInResponse({this.data,required this.timestamp, this.path});

  factory AuthenticationSignInResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationSignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationSignInResponseToJson(this);
}

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}