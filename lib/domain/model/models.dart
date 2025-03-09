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
