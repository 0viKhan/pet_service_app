import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _accessTokenKey = 'access_token';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _firstNameKey = 'first_name';
  static const String _lastNameKey = 'last_name';
  static const String _emailKey = 'email';
  static const String _profileImageKey = 'profile_image';

  /// Save login data
  static Future<void> saveLogin({
    required String accessToken,
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setBool(_isLoggedInKey, true);

    if (firstName != null) {
      await prefs.setString(_firstNameKey, firstName);
    }

    if (lastName != null) {
      await prefs.setString(_lastNameKey, lastName);
    }

    if (email != null) {
      await prefs.setString(_emailKey, email);
    }
  }

  /// Get token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  /// Check login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// First name
  static Future<String> getFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_firstNameKey) ?? '';
  }

  /// Last name
  static Future<String> getLastName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastNameKey) ?? '';
  }

  /// Email
  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey) ?? '';
  }

  /// Full name
  static Future<String> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString(_firstNameKey) ?? '';
    final lastName = prefs.getString(_lastNameKey) ?? '';
    return '$firstName $lastName'.trim();
  }

  /// Save profile image
  static Future<void> saveProfileImage(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, imageUrl);
  }

  /// Get profile image
  static Future<String?> getProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileImageKey);
  }

  /// Clear login
  static Future<void> clearLogin() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_accessTokenKey);
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_firstNameKey);
    await prefs.remove(_lastNameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_profileImageKey);
  }
}