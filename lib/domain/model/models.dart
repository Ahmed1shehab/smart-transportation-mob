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


//signIn
// domain_models.dart

class AccessToken {
  final String value;

  AccessToken(this.value);
}

class AuthenticationSignIn {
  final String token;
  final String message;

  AuthenticationSignIn({required this.token, required this.message});

  factory AuthenticationSignIn.fromJson(Map<String, dynamic> json) {
    return AuthenticationSignIn(
      token: json['access_token'] ?? Constants.empty,
      message: json['message'] ?? Constants.empty,
    );
  }
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
  final User user;
  final String id;
  final int v;

  Owner({
    required this.user,
    required this.id,
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