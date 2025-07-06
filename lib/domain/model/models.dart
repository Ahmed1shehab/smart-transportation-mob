//Slider models\
import 'package:smart_transportation/app/constants.dart';

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.currentIndex, this.numberOfSlides);
}

class AccessToken {
  final String value;

  AccessToken(this.value);
}

//signIn  -- Login
class AuthenticationSignIn {
  final String token;
  final String accountType;
  final String message;

  AuthenticationSignIn({
    required this.token,
    required this.accountType,
    required this.message,
  });

  factory AuthenticationSignIn.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AuthenticationSignIn(
      token: data['access_token'] ?? Constants.empty,
      accountType: data['account_type'] ?? Constants.empty,
      message: json['message'] ?? Constants.empty,
    );
  }
}

//SignUp --Register
class AuthenticationSignUp {
  final User user;
  final String message;
  final String timestamp;
  final String path;

  AuthenticationSignUp({
    required this.user,
    required this.message,
    required this.timestamp,
    required this.path,
  });
}

//Organization Domain model
class Organizer {
  final String name;
  final String type;
  final String image;
  final String description;
  final String address;
  final Owner owner;
  final String id;
  final int v;

  Organizer({
    required this.name,
    required this.type,
    required this.image,
    required this.description,
    required this.address,
    required this.owner,
    required this.id,
    required this.v,
  });
}

class Owner {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String status;
  final String image;
  final int v;

  Owner({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.status,
    required this.image,
    required this.v,
  });
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String status;
  final int v;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.status,
    required this.v,
  });
}

class OrganizationItem {
  final String id;
  final String name;
  final String type;
  final String image;
  final String description;
  final String address;
  final String owner;
  final int v;

  OrganizationItem({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.description,
    required this.address,
    required this.owner,
    required this.v,
  });

  String get fullImageUrl {
    return image.replaceAll('\\', '/').replaceFirst('localhost', '192.168.1.24');
  }
}

class GetAllOrganizationsData {
  final List<OrganizationItem> results;
  final int totalPages;
  final int currentPage;

  GetAllOrganizationsData({
    required this.results,
    required this.totalPages,
    required this.currentPage,
  });
}

// Driver Domain Model
class Driver {
  final String licenseInfo;
  final DateTime licenseDate;
  final OrganizationEmployee employee;
  final String organizationId;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Driver({
    required this.licenseInfo,
    required this.licenseDate,
    required this.employee,
    required this.organizationId,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}

class OrganizationEmployee {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String image;
  final String status;
  final String organizationId;
  final String id;
  final int v;

  OrganizationEmployee({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.image,
    required this.status,
    required this.organizationId,
    required this.id,
    required this.v,
  });

  String get fullImageUrl {
    return image.replaceAll('\\', '/').replaceFirst('localhost', '10.0.2.2');
  }
}
