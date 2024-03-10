import 'package:washaacustomer/data/models/address_model.dart';
import 'package:washaacustomer/data/models/car_model.dart';
import 'package:washaacustomer/data/models/washer_model.dart';

class OrderModel {
  final String id;
  final String status;
  final String price;
  final String date;
  final String initialProofImage;
  final String finalProofImage;
  final String longitude;
  final String latitude;
  final int customerValiation;
  final CarModel car;
  final AddressModel address;
  final WasherModel washer;

  OrderModel({
    required this.id,
    required this.status,
    required this.price,
    required this.date,
    required this.initialProofImage,
    required this.finalProofImage,
    required this.longitude,
    required this.latitude,
    required this.customerValiation,
    required this.car,
    required this.address,
    required this.washer,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      price: json['price'] ?? '',
      date: json['date'] ?? '',
      initialProofImage: json['initialProofImage'] ?? '',
      finalProofImage: json['finalProofImage'] ?? '',
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
      customerValiation: json['customerValiation'] ?? '',
      car: CarModel.fromJson(json['car']),
      address: AddressModel.fromJson(json['address']),
      washer: WasherModel.fromJson(json['washer']),
    );
  }
}