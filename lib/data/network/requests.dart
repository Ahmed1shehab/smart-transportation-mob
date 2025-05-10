import 'dart:io';

import 'package:dio/dio.dart';
//Login Request
class LoginRequest {
  String identifier;

  String password;

  LoginRequest(this.identifier, this.password);
}


//Register Request
class RegisterRequest {
  File image;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;

  RegisterRequest(this.image,this.firstName, this.lastName, this.email, this.phoneNumber,
      this.password);
  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    });

     {
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(image.path,
            filename: 'user_${DateTime.now().millisecondsSinceEpoch}.jpg'),
      ));
    }

    return formData;
  }
}
//Organizer Onboard Request
class CreateOrganizerRequest {
  final String name;
  final String type;
  final String phoneNumber;
  final String description;
  final File image;
  final String street;
  final String city;
  final String state;
  final String postalCode;

  CreateOrganizerRequest({
    required this.name,
    required this.type,
    required this.phoneNumber,
    required this.description,
    required this.image,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
  });


  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'name': name,
      'type': type,
      'phoneNumber': phoneNumber,
      'description': description,
      'image': await MultipartFile.fromFile(image.path,
          filename: 'organizer_${DateTime.now().millisecondsSinceEpoch}.jpg'),
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
    });
  }
}

//create new organization request


class CreateNewOrganizationRequest {
  final String name;
  final String type;
  final String phoneNumber;
  final String description;
  final File image;
  final String addressId;

  CreateNewOrganizationRequest({
    required this.name,
    required this.type,
    required this.phoneNumber,
    required this.description,
    required this.image,
    required this.addressId,
  });


  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'name': name,
      'type': type,
      'phoneNumber': phoneNumber,
      'description': description,
      'image': await MultipartFile.fromFile(image.path,
          filename: 'organizer_${DateTime.now().millisecondsSinceEpoch}.jpg'),
      'addressId': addressId,
    });
  }
}
// Create Driver Request
class CreateDriverRequest {
  final String licenseInfo;
  final DateTime licenseDate;
  final File image;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String organization;

  CreateDriverRequest({
    required this.licenseInfo,
    required this.licenseDate,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.organization,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'licenseInfo': licenseInfo,
      'licenseDate': licenseDate.toIso8601String(),
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'organization': organization,
      'image': await MultipartFile.fromFile(image.path,
          filename: 'driver_${DateTime.now().millisecondsSinceEpoch}.jpg'),
    });
  }
}