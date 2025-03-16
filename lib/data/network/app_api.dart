import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_transportation/app/constants.dart';
import 'package:smart_transportation/data/response/response.dart';

part 'app_api.g.dart'; // Generated file

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/api/auth/signin")
  Future<AuthenticationSignInResponse> login(
    @Field("identifier") String identifier,
    @Field("password") String password,
  );

  @MultiPart()
  @POST('/api/store/details')
  Future<CreateOrganizerResponse> createNewOrganizer(
    @Field('name') String name,
    @Field('type') String type,
    @Field('phoneNumber') String phoneNumber,
    @Field('description') String description,
    @Part(name: 'image', contentType: "application/octet-stream")
    MultipartFile image,
    @Field('street') String street,
    @Field('city') String city,
    @Field('state') String state,
    @Field('postalCode') String postalCode,
  );
}
