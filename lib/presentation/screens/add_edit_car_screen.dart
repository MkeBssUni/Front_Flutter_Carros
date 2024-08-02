import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:front_carros/model/car_model.dart';
import 'package:front_carros/presentation/cubits/car_cubit.dart';

class AddEditCarScreen extends StatefulWidget {
  final Car? car;

  const AddEditCarScreen({super.key, this.car});

  @override
  // ignore: library_private_types_in_public_api
  _AddEditCarScreenState createState() => _AddEditCarScreenState();
}

class _AddEditCarScreenState extends State<AddEditCarScreen> {
  final _formKey = GlobalKey<FormState>();
  late String brand;
  late String model;
  late String year;
  late String color;

  @override
  void initState() {
    super.initState();
    brand = widget.car?.brand ?? '';
    model = widget.car?.model ?? '';
    year = widget.car?.year ?? '';
    color = widget.car?.color ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car == null ? 'Registrar' : 'Editar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: brand,
                maxLength: 255,
                decoration: const InputDecoration(labelText: 'Marca'),
                onSaved: (value) => brand = value!,
                validator: (value) =>
                    value!.isEmpty ? 'La marca es requerida' : null,
              ),
              TextFormField(
                initialValue: model,
                maxLength: 255,
                decoration: const InputDecoration(labelText: 'Modelo'),
                onSaved: (value) => model = value!,
                validator: (value) =>
                    value!.isEmpty ? 'El modelo es requerido' : null,
              ),
              TextFormField(
                initialValue: year,
                maxLength: 4,
                decoration: const InputDecoration(labelText: 'Año'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onSaved: (value) => year = value!,
                validator: (value) =>
                    value!.isEmpty ? 'El año es requerido' : null,
              ),
              TextFormField(
                initialValue: color,
                maxLength: 255,
                decoration: const InputDecoration(labelText: 'Color'),
                onSaved: (value) => color = value!,
                validator: (value) =>
                    value!.isEmpty ? 'El color es requerido' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final car = Car(
                      id: widget.car?.id ?? 0,
                      brand: brand,
                      model: model,
                      year: year,
                      color: color,
                    );
                    if (widget.car == null) {
                      BlocProvider.of<CarCubit>(context).saveCar(car);
                    } else {
                      BlocProvider.of<CarCubit>(context).updateCar(car);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.car == null ? 'Registrar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
