class ApiConstants {
  static const String baseUrl = 'http://23.239.111.164:5022/api/v1';

  /// auth

  static const String signUp = '$baseUrl/auth/sign-up';
  static const String verifyRegisterOtp = '$baseUrl/auth/verify-account';
  static const String changePassword  = '$baseUrl/auth/change-password';
  static const String updateProfile = '$baseUrl/users/update-profile';
  static const String logout = '$baseUrl/auth/logout';
  static const String myParks  = '$baseUrl/parks/my-parks';
  static const String myPet  = '$baseUrl/pets';


}