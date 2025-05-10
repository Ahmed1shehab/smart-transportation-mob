// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      timestamp: json['timestamp'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'timestamp': instance.timestamp,
      'path': instance.path,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
      accessToken: json['access_token'] as String?,
      accountType: json['account_type'] as String?,
    );

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'account_type': instance.accountType,
    };

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      image: json['image'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String?,
      status: json['status'] as String?,
      id: json['_id'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      'image': instance.image,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'status': instance.status,
      '_id': instance.id,
      '__v': instance.v,
    };

OrganizerData _$OrganizerDataFromJson(Map<String, dynamic> json) =>
    OrganizerData(
      json['name'] as String,
      json['type'] as String,
      json['image'] as String,
      json['description'] as String,
      json['address'] as String,
      OwnerData.fromJson(json['owner'] as Map<String, dynamic>),
      json['_id'] as String,
      (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$OrganizerDataToJson(OrganizerData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'image': instance.image,
      'description': instance.description,
      'address': instance.address,
      'owner': instance.owner,
      '_id': instance.organizerId,
      '__v': instance.v,
    };

OwnerData _$OwnerDataFromJson(Map<String, dynamic> json) => OwnerData(
      json['_id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      json['phoneNumber'] as String,
      json['password'] as String,
      json['status'] as String,
      json['image'] as String,
      (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$OwnerDataToJson(OwnerData instance) => <String, dynamic>{
      '_id': instance.ownerId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'status': instance.status,
      'image': instance.image,
      '__v': instance.v,
    };

OrganizationResponse _$OrganizationResponseFromJson(
        Map<String, dynamic> json) =>
    OrganizationResponse(
      json['_id'] as String?,
      json['name'] as String?,
      json['type'] as String?,
      json['image'] as String?,
      json['description'] as String?,
      json['address'] as String?,
      json['owner'] as String?,
    )..v = (json['__v'] as num?)?.toInt();

Map<String, dynamic> _$OrganizationResponseToJson(
        OrganizationResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'image': instance.image,
      'description': instance.description,
      'address': instance.address,
      'owner': instance.owner,
      '__v': instance.v,
    };

GetAllOrganizationsDataResponse _$GetAllOrganizationsDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllOrganizationsDataResponse(
      (json['results'] as List<dynamic>?)
          ?.map((e) => OrganizationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['totalPages'] as num?)?.toInt(),
      (json['currentPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetAllOrganizationsDataResponseToJson(
        GetAllOrganizationsDataResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
    };

CreateDriverData _$CreateDriverDataFromJson(Map<String, dynamic> json) =>
    CreateDriverData(
      licenseInfo: json['licenseInfo'] as String?,
      licenseDate: json['licenseDate'] as String?,
      employee: json['employee'] == null
          ? null
          : EmployeeData.fromJson(json['employee'] as Map<String, dynamic>),
      organization: json['organization'] as String?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreateDriverDataToJson(CreateDriverData instance) =>
    <String, dynamic>{
      'licenseInfo': instance.licenseInfo,
      'licenseDate': instance.licenseDate,
      'employee': instance.employee,
      'organization': instance.organization,
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

EmployeeData _$EmployeeDataFromJson(Map<String, dynamic> json) => EmployeeData(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String?,
      image: json['image'] as String?,
      status: json['status'] as String?,
      organization: json['organization'] as String?,
      id: json['_id'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EmployeeDataToJson(EmployeeData instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'image': instance.image,
      'status': instance.status,
      'organization': instance.organization,
      '_id': instance.id,
      '__v': instance.v,
    };
