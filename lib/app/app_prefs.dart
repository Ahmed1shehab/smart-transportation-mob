import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_transportation/presentation/resources/language_manager.dart';

const String prefKeyLang = "PREFS_KEY_LANG";
const String prefKeyOnBoardingScreenViewed =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String prefKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefKeyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      //return default language
      return LanguageType.english.getValue();
    }
  }

//   //onBoarding
//   Future<void> setOnBoardingScreenViewed() async {
//     _sharedPreferences.setBool(prefKeyOnBoardingScreenViewed, true);
//   }
//
// //
//   Future<bool> isOnBoardingScreenViewed() async {
//     return _sharedPreferences.getBool(prefKeyOnBoardingScreenViewed) ?? false;
//   }
//
//   //login
//   Future<void> setUserLoggedIn() async {
//     _sharedPreferences.setBool(prefKeyIsUserLoggedIn, true);
//   }
//
// //
//   Future<bool> isUserLoggedIn() async {
//     return _sharedPreferences.getBool(prefKeyIsUserLoggedIn) ?? false;
//   }
}
