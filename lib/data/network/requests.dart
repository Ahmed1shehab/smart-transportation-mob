import 'dart:io';

import 'package:dio/dio.dart';

class LoginRequest {
  String identifier;

  String password;

  LoginRequest(this.identifier, this.password);
}

class CreateOrganizerRequest {
  String name;
  String type;
  String phoneNumber;
  String description;
  MultipartFile image;
  String street;
  String city;
  String state;
  String postalCode;

  CreateOrganizerRequest(
      this.name,
      this.type,
      this.phoneNumber,
      this.description,
      this.image,
      this.street,
      this.city,
      this.state,
      this.postalCode);
}
