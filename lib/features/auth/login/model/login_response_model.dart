class LoginResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final LoginData data;

  LoginResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: LoginData.fromJson(json['data'] ?? {}),
    );
  }
}

class LoginData {
  final UserModel user;
  final String accessToken;
  final String message;

  LoginData({
    required this.user,
    required this.accessToken,
    required this.message,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: UserModel.fromJson(json['user'] ?? {}),
      accessToken: json['accessToken'] ?? '',
      message: json['message'] ?? '',
    );
  }
}

class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final bool isDeleted;
  final String phone;
  final bool isAccountVerified;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.isDeleted,
    required this.phone,
    required this.isAccountVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      role: json['role'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      phone: json['phone'] ?? '',
      isAccountVerified: json['isAccountVerified'] ?? false,
    );
  }
}