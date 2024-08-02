import 'dart:convert';
import 'package:front_carros/model/car_model.dart';
import 'package:http/http.dart' as http;

class CarRepository {
  final String apiUrl = 'https://qvz2adk88k.execute-api.us-east-2.amazonaws.com/Prod';

  CarRepository();

  Future<List<Car>> getCars() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/get_cars'),
      );

      if (response.statusCode == 200) {
        List<dynamic> carsJson = jsonDecode(response.body)['cars'];
        List<Car> cars = carsJson.map((car) => Car.fromJson(car)).toList();
        return cars;
      } else {
        throw Exception('Failed to fetch cars');
      }
    } catch (e) {
      print('Error getCars: $e');
      throw Exception('Failed to fetch cars');
    }
  }

  Future<void> saveCar(Car car) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/save_car'),
        body: jsonEncode(car.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to save car');
      }
    } catch (e) {
      print('Error saveCar $e');
      throw Exception('Failed to save car');
    }
  }

  Future<void> updateCar(Car car) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/update_car'),
        body: jsonEncode(car.toJson())
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update car');
      }
    } catch (e) {
      print('Error updateCar $e');
      throw Exception('Failed to update car');
    }
  }

  Future<void> deleteCar(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/delete/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete car');
      }
    } catch (e) {
      print('Error deleteCar $e');
      throw Exception('Failed to delete car');
    }
  }
}
