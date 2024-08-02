import 'package:equatable/equatable.dart';
import 'package:front_carros/model/car_model.dart';


abstract class CarState extends Equatable {
  const CarState();

  @override
  List<Object> get props => [];
}

class CarInitial extends CarState{}

class CarLoading extends CarState{}

class CarSuccess extends CarState{
  final List<Car> cars;
  const CarSuccess({required this.cars});

  @override
  List<Object> get props => [cars];
}

class CarError extends CarState{
  final String message;
  const CarError({required this.message});

  @override
  List<Object> get props => [message];
}