class CarModel{
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String brand;
  final String matricule;
  final String size;
  final String color;
  final String year;
  final String date;

  CarModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.brand,
    required this.matricule,
    required this.size,
    required this.color,
    required this.year,
    required this.date,
  });

  factory CarModel.fromJson(Map<String, dynamic> json){
    return CarModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      brand: json['brand'],
      matricule: json['matricule'],
      size: json['size'],
      color: json['color'],
      year: json['year'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'description': description,
    'brand': brand,
    'matricule': matricule,
    'size': size,
    'color': color,
    'year': year,
    'date': date,
  };
}

class CarModelList {
  List<CarModel> carList;

  CarModelList({required this.carList});

  factory CarModelList.fromJson(List<dynamic> list){
    List<CarModel> carList = [];
    list.forEach((element) {
      carList.add(CarModel.fromJson(element));
    });
    return CarModelList(carList: carList);
  }
}