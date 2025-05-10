import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String identifier, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(File image, String firstName,String lastName,String email, String phoneNumber, String password) = _RegisterObject;
}


@freezed
class CreateOrganizerObject with _$CreateOrganizerObject {
  factory CreateOrganizerObject(
    String name,
    String type,
    String phoneNumber,
    String description,
    File image,
    String street,
    String city,
    String state,
    String postalCode,
      {@Default("") String imagePath,
      }
  ) = _CreateOrganizerObject;
}
@freezed
class CreateNewOrganizerObject with _$CreateNewOrganizerObject {
  factory CreateNewOrganizerObject(
    String name,
    String type,
    String phoneNumber,
    String description,
    File image,
    String addressId,
      {@Default("") String imagePath,
      }
  ) = _CreateNewOrganizerObject;
}
@freezed
class CreateDriverObject with _$CreateDriverObject {
  factory CreateDriverObject(
      String licenseInfo,
      DateTime? licenseDate,
      File image,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      String organizationId,
      {@Default("") String imagePath,
      }
      ) = _CreateDriverObject;
}