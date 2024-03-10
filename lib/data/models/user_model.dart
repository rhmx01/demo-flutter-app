import 'customer_model.dart';

class UserModel {
  final int id;
  final String email;
  final String phone;
  final String role;
  final CustomerModel customer;
  final int passwordReset;
  final int status;

  UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.role,
    required this.customer,
    required this.passwordReset,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      customer: CustomerModel.fromJson(json['profile']),
      passwordReset: json['passwordReset'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
