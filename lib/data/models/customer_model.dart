class CustomerModel {
  final int id;
  final String firstname;
  final String lastname;
  final String uid;
  final String email;
  final String phone;
  final String country;
  final String city;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CustomerModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.uid,
    required this.email,
    required this.phone,
    required this.country,
    required this.city,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}
