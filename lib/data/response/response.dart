import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  T? data;
  @JsonKey(name: "timestamp")
  String? timestamp;
  @JsonKey(name: "path")
  String? path;

  BaseResponse({this.status, this.message, this.data, this.timestamp, this.path});

  factory BaseResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(T Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}

//Sign In Response
@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'account_type')
  final String? accountType;

  DataResponse({this.accessToken, this.accountType});

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}

typedef AuthenticationSignInResponse = BaseResponse<DataResponse>;

//Register - SignUp
@JsonSerializable()
class UserDataResponse {
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: '__v')
  final int? v;

  UserDataResponse({
    this.image,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
    this.status,
    this.id,
    this.v,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}

typedef AuthenticationSignUpResponse = BaseResponse<UserDataResponse>;

//Organization Response

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

typedef CreateOrganizerResponse = BaseResponse<OrganizerData>;

@JsonSerializable()
class OwnerData {
  @JsonKey(name: '_id')
  String ownerId;
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
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: '__v')
  int v;

  OwnerData(
      this.ownerId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.password,
      this.status,
      this.image,
      this.v,
      );

  factory OwnerData.fromJson(Map<String, dynamic> json) =>
      _$OwnerDataFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerDataToJson(this);
}




//getAllOrganizations -- one organization
@JsonSerializable()
class OrganizationResponse {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "owner")
  String? owner;
  @JsonKey(name: "__v")
  int? v;

  OrganizationResponse(
      this.id,
      this.name,
      this.type,
      this.image,
      this.description,
      this.address,
      this.owner,
      );

  factory OrganizationResponse.fromJson(Map<String, dynamic> json) =>
      _$OrganizationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationResponseToJson(this);
}

@JsonSerializable()
class GetAllOrganizationsDataResponse {
  @JsonKey(name: "results")
  List<OrganizationResponse>? results;
  @JsonKey(name: "totalPages")
  int? totalPages;
  @JsonKey(name: "currentPage")
  int? currentPage;

  GetAllOrganizationsDataResponse(
      this.results,
      this.totalPages,
      this.currentPage,
      );

  factory GetAllOrganizationsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllOrganizationsDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetAllOrganizationsDataResponseToJson(this);
}

typedef GetAllOrganizationsResponse = BaseResponse<GetAllOrganizationsDataResponse>;
typedef GetOneOrganizationResponse = BaseResponse<OrganizationResponse>;

// Create Driver Response
@JsonSerializable()
class CreateDriverData {
  @JsonKey(name: 'licenseInfo')
  String? licenseInfo;
  @JsonKey(name: 'licenseDate')
  String? licenseDate;
  @JsonKey(name: 'employee')
  EmployeeData? employee;
  @JsonKey(name: 'organization')
  String? organization;
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  CreateDriverData({
    this.licenseInfo,
    this.licenseDate,
    this.employee,
    this.organization,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CreateDriverData.fromJson(Map<String, dynamic> json) =>
      _$CreateDriverDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDriverDataToJson(this);
}

@JsonSerializable()
class EmployeeData {
  @JsonKey(name: 'firstName')
  String? firstName;
  @JsonKey(name: 'lastName')
  String? lastName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'password')
  String? password;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'organization')
  String? organization;
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: '__v')
  int? v;

  EmployeeData({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
    this.image,
    this.status,
    this.organization,
    this.id,
    this.v,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDataFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDataToJson(this);
}

typedef CreateDriverResponse = BaseResponse<CreateDriverData>;