import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

//Sign In Response
@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'access_token')
  final String? accessToken;

  DataResponse({this.accessToken});

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}

@JsonSerializable()
class AuthenticationSignInResponse extends BaseResponse {
  @JsonKey(name: 'data')
  DataResponse? data;

  @JsonKey(name: 'timestamp')
  String? timestamp;

  @JsonKey(name: 'path')
  String? path;

  AuthenticationSignInResponse({this.data, required this.timestamp, this.path});

  factory AuthenticationSignInResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationSignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationSignInResponseToJson(this);
}


//Organization Response

@JsonSerializable()
class CreateOrganizerResponse extends BaseResponse {
  @JsonKey(name: 'data')
  OrganizerData data;
  @JsonKey(name: 'timestamp')
  String? timestamp;
  @JsonKey(name: 'path')
  String? path;

  CreateOrganizerResponse(this.data, this.timestamp, this.path);

  factory CreateOrganizerResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOrganizerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrganizerResponseToJson(this);
}

@JsonSerializable()
class OrganizerData {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'address')
  String address;
  @JsonKey(name: 'owner')
  OwnerData owner;

  @JsonKey(name: '_id')
  String organizerId;
  @JsonKey(name: '__v')
  int v;

  OrganizerData(this.name, this.type, this.image, this.description,
      this.address, this.owner, this.organizerId, this.v);

  factory OrganizerData.fromJson(Map<String, dynamic> json) =>
      _$OrganizerDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizerDataToJson(this);
}

@JsonSerializable()
class OwnerData {
  @JsonKey(name: "user")
  UserData user;
  @JsonKey(name: '_id')
  String ownerId;
  @JsonKey(name: '__v')
  int v;

  OwnerData(this.user, this.ownerId, this.v);

  factory OwnerData.fromJson(Map<String, dynamic> json) =>
      _$OwnerDataFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerDataToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: '_id')
  String userId;
  @JsonKey(name: 'firstName')
  String firstName;
  @JsonKey(name: 'lastName')
  String lastName;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'phoneNumber')
  String phoneNumber;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: '__v')
  int v;

  UserData(this.userId, this.firstName, this.lastName, this.email, this.phoneNumber,
      this.password, this.status, this.v);

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}