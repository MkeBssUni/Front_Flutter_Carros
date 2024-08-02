class Car {
  final int id;
  final String brand;
  final String model;
  final String year;
  final String color;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as int,
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: json['year'].toString(),  // Convertir a String
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'year': year,
      'color': color,
    };
  }
}
