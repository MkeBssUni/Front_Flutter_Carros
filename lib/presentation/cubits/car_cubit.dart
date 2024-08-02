import 'package:bloc/bloc.dart';
import 'package:front_carros/model/car_model.dart';
import 'package:front_carros/presentation/car_state.dart';
import 'package:front_carros/repository/car_repository.dart';

class CarCubit extends Cubit<CarState>{
  final CarRepository carRepository;

  CarCubit({required this.carRepository}) : super(CarInitial());

  Future<void> getCars() async {
    try{
      emit(CarLoading());
      final cars = await carRepository.getCars();
      emit(CarSuccess(cars: cars));
    }catch(e){
      emit(CarError(message: e.toString()));
    }
  }

  Future<void> saveCar(Car car) async {
    try{
      emit(CarLoading());
      await carRepository.saveCar(car);
      getCars();
    }catch(e){
      emit(CarError(message: e.toString()));
    }
  }

  Future<void> updateCar(Car car) async {
    try{
      emit(CarLoading());
      await carRepository.updateCar(car);
      getCars();
    }catch(e){
      emit(CarError(message: e.toString()));
    }
  }

  Future<void> deleteCar(int id) async {
    try{
      emit(CarLoading());
      await carRepository.deleteCar(id);
      getCars();
    }catch(e){
      emit(CarError(message: e.toString()));
    }
  }
}