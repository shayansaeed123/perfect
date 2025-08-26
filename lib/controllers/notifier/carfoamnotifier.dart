

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/models/carfoammodel.dart';

class CarFormNotifier extends StateNotifier<CarFormData> {
  CarFormNotifier() : super(CarFormData());

  void updateCustomerDetails({
    String? requestedFor,
    String? customerName,
    String? inspectionDate,
    String? address,
    String? evaluationNo,
  }) {
    state = CarFormData(
      requestedFor: requestedFor ?? state.requestedFor,
      customerName: customerName ?? state.customerName,
      inspectionDate: inspectionDate ?? state.inspectionDate,
      address: address ?? state.address,
      evaluationNo: evaluationNo ?? state.evaluationNo,
      make: state.make,
      model: state.model,
      year: state.year,
      plateNo: state.plateNo,
      vin: state.vin,
      engineNo: state.engineNo,
      color: state.color,
      fuelType: state.fuelType,
      option: state.option,
      trim: state.trim,
      odometer: state.odometer,
      specification: state.specification,
      bodyType: state.bodyType,
      cylinders: state.cylinders,
      transmission: state.transmission,
      carCondition: state.carCondition,
      carFrontImage: state.carFrontImage,
      carBackImage: state.carBackImage,
    );
  }

  void updateCarDetails1({
    String? make,
    String? model,
    String? year,
    String? plateNo,
    String? vin,
    String? engineNo,
    String? color,
    String? fuelType,
    String? option,
  }) {
    state = CarFormData(
      requestedFor: state.requestedFor,
      customerName: state.customerName,
      inspectionDate: state.inspectionDate,
      address: state.address,
      evaluationNo: state.evaluationNo,
      make: make ?? state.make,
      model: model ?? state.model,
      year: year ?? state.year,
      plateNo: plateNo ?? state.plateNo,
      vin: vin ?? state.vin,
      engineNo: engineNo ?? state.engineNo,
      color: color ?? state.color,
      fuelType: fuelType ?? state.fuelType,
      option: option ?? state.option,
      trim: state.trim,
      odometer: state.odometer,
      specification: state.specification,
      bodyType: state.bodyType,
      cylinders: state.cylinders,
      transmission: state.transmission,
      carCondition: state.carCondition,
      carFrontImage: state.carFrontImage,
      carBackImage: state.carBackImage,
    );
  }

  void updateCarDetails2({
    String? trim,
    String? odometer,
    String? specification,
    String? bodyType,
    String? cylinders,
    String? transmission,
    String? carCondition,
  }) {
    state = CarFormData(
      requestedFor: state.requestedFor,
      customerName: state.customerName,
      inspectionDate: state.inspectionDate,
      address: state.address,
      evaluationNo: state.evaluationNo,
      make: state.make,
      model: state.model,
      year: state.year,
      plateNo: state.plateNo,
      vin: state.vin,
      engineNo: state.engineNo,
      color: state.color,
      fuelType: state.fuelType,
      option: state.option,
      trim: trim ?? state.trim,
      odometer: odometer ?? state.odometer,
      specification: specification ?? state.specification,
      bodyType: bodyType ?? state.bodyType,
      cylinders: cylinders ?? state.cylinders,
      transmission: transmission ?? state.transmission,
      carCondition: carCondition ?? state.carCondition,
      carFrontImage: state.carFrontImage,
      carBackImage: state.carBackImage,
    );
  }

  void updateCarImages({String? front, String? back}) {
    state = CarFormData(
      // pehle ke sab fields carry forward karo
      requestedFor: state.requestedFor,
      customerName: state.customerName,
      inspectionDate: state.inspectionDate,
      address: state.address,
      evaluationNo: state.evaluationNo,
      make: state.make,
      model: state.model,
      year: state.year,
      plateNo: state.plateNo,
      vin: state.vin,
      engineNo: state.engineNo,
      color: state.color,
      fuelType: state.fuelType,
      option: state.option,
      trim: state.trim,
      odometer: state.odometer,
      specification: state.specification,
      bodyType: state.bodyType,
      cylinders: state.cylinders,
      transmission: state.transmission,
      carCondition: state.carCondition,
      // ab naya add
      carFrontImage: front ?? state.carFrontImage,
      carBackImage: back ?? state.carBackImage,
    );
  }
}

final carFormProvider = StateNotifierProvider<CarFormNotifier, CarFormData>((ref) {
  return CarFormNotifier();
});
