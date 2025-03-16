// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = (json['status'] as num?)?.toInt()
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
      accessToken: json['access_token'] as String?,
    );

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
    };

AuthenticationSignInResponse _$AuthenticationSignInResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationSignInResponse(
      data: json['data'] == null
          ? null
          : DataResponse.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String?,
      path: json['path'] as String?,
    )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationSignInResponseToJson(
        AuthenticationSignInResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'timestamp': instance.timestamp,
      'path': instance.path,
    };

CreateOrganizerResponse _$CreateOrganizerResponseFromJson(
        Map<String, dynamic> json) =>
    CreateOrganizerResponse(
      OrganizerData.fromJson(json['data'] as Map<String, dynamic>),
      json['timestamp'] as String?,
      json['path'] as String?,
    )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$CreateOrganizerResponseToJson(
        CreateOrganizerResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'timestamp': instance.timestamp,
      'path': instance.path,
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
      UserData.fromJson(json['user'] as Map<String, dynamic>),
      json['_id'] as String,
      (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$OwnerDataToJson(OwnerData instance) => <String, dynamic>{
      'user': instance.user,
      '_id': instance.ownerId,
      '__v': instance.v,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      json['_id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      json['phoneNumber'] as String,
      json['password'] as String,
      json['status'] as String,
      (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      '_id': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'status': instance.status,
      '__v': instance.v,
    };
