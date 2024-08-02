import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_carros/presentation/cubits/car_cubit.dart';
import 'package:front_carros/repository/car_repository.dart';
import 'package:front_carros/presentation/car_state.dart';
import 'package:front_carros/presentation/screens/add_edit_car_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final CarRepository carRepository = CarRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<CarCubit>(
          create: (context) => CarCubit(carRepository: carRepository)..getCars(),
        ),
      ],
      child: const  MaterialApp(
        title: 'Practica Carros',
        home: CarListScreen(),
      ),
    );
  }
}

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de carros'),
      ),
      body: BlocBuilder<CarCubit, CarState>(
        builder: (context, state) {
          if (state is CarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CarSuccess) {
            return ListView.builder(
              itemCount: state.cars.length,
              itemBuilder: (context, index) {
                final car = state.cars[index];
                return ListTile(
                  title: Text('${car.brand} ${car.model}'),
                  subtitle: Text(car.year),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditCarScreen(car: car),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<CarCubit>().deleteCar(car.id);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditCarScreen(car: car),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is CarError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CarCubit>().getCars();
                    },
                    child: const Text('Volver a cargar'),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditCarScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}