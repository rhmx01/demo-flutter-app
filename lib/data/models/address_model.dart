class AddressModel {
  int id;
  String? name;
  String? address;
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  String? longitude;
  String? latitude;

  AddressModel({
    required this.id,
    this.name,
    this.address,
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.longitude,
    this.latitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      street: json['street'] ?? '',
      suite: json['suite'] ?? '',
      city: json['city'] ?? '',
      zipcode: json['zipcode'] ?? '',
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
    );
  }

  }

class AddressModelList {
  List<AddressModel> addresses;

  AddressModelList({required this.addresses});

  factory AddressModelList.fromJson(List<dynamic> json) {
    List<AddressModel> addresses = [];
    addresses = json.map((i) => AddressModel.fromJson(i)).toList();
    return AddressModelList(addresses: addresses);
  }
}


