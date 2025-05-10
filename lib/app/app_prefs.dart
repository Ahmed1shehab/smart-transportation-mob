import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_transportation/presentation/resources/language_manager.dart';

const String prefKeyLang = "PREFS_KEY_LANG";
const String prefKeyOnBoardingScreenViewed =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String prefKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
const String _keyAccessToken = 'access_token';
const String _keyOnBoardingViewed = 'onboarding_viewed';
const String _keyActiveOwner = 'active_owner';

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

  //Token
  Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccessToken, token);
  }

  Future<String?> getAccessToken() async {
    return _sharedPreferences.getString(_keyAccessToken);
  }

  Future<void> deleteAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAccessToken);
  }

  Future<void> updateAccessToken(String newToken) async {
    await _sharedPreferences.setString(_keyAccessToken, newToken);
  }

  //onBoarding
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(prefKeyOnBoardingScreenViewed, true);
  }



//
  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(prefKeyOnBoardingScreenViewed) ?? false;
  }

  //login
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(prefKeyIsUserLoggedIn, true);
  }

//
  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefKeyIsUserLoggedIn) ?? false;
  }

  static Future<void> markOnBoardingViewed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnBoardingViewed, true);
  }

  // Check if onboarding is viewed
  static Future<bool> isOnBoardingViewed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnBoardingViewed) ?? false;
  }

  Future<void> setActiveOwner(String ownerId) async {
    
    await _sharedPreferences.setString(_keyActiveOwner, ownerId);
    
  }

  /// Get Active Owner
  Future<String?> getActiveOwner() async {
    return _sharedPreferences.getString(_keyActiveOwner);
  }

  /// Remove Active Owner (e.g., on logout)
  Future<void> clearActiveOwner() async {
    await _sharedPreferences.remove(_keyActiveOwner);
  }
}
