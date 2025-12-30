

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerValidationState {
  final String? errorMessage;
  CustomerValidationState({this.errorMessage});
}

class CustomerValidationNotifier extends StateNotifier<CustomerValidationState> {
  CustomerValidationNotifier() : super(CustomerValidationState());

  String? validate({
    required String requestedFor,
    required String? bankName,
    required String customerName,
    required String inspectionDate,
    required String address,
    required String customerEmail
    // required String evaluationNo,
  }) {
    if (requestedFor.isEmpty) {
      state = CustomerValidationState(errorMessage: "⚠️ bank person email is requried");
      return state.errorMessage;
    } else if (bankName == null || bankName.isEmpty) {
      state = CustomerValidationState(errorMessage: "⚠️ Bank Name is required");
      return state.errorMessage;
    } else if (customerName.isEmpty) {
      state = CustomerValidationState(errorMessage: "⚠️ Customer Name is required");
      return state.errorMessage;
    } 
    else if (inspectionDate.isEmpty) {
      state = CustomerValidationState(errorMessage: "⚠️ Inspection Date is required");
      return state.errorMessage;
    } 
    else if (address.isEmpty) {
      state = CustomerValidationState(errorMessage: "⚠️ Address is required");
      return state.errorMessage;
    } else if (customerEmail.isEmpty){
      state = CustomerValidationState(errorMessage: "Customer Email is requried");
    }
    // else if (evaluationNo.isEmpty) {
    //   state = CustomerValidationState(errorMessage: "⚠️ Evaluation No is required");
    //   return state.errorMessage;
    // }

    // ✅ All Good
    state = CustomerValidationState(errorMessage: null);
    return null;
  }
}

final customerValidationProvider =
    StateNotifierProvider<CustomerValidationNotifier, CustomerValidationState>(
        (ref) => CustomerValidationNotifier());



class CarDetails1ValidationState {
  final String? errorMessage;
  CarDetails1ValidationState({this.errorMessage});
}

class CarDetails1ValidationNotifier
    extends StateNotifier<CarDetails1ValidationState> {
  CarDetails1ValidationNotifier() : super(CarDetails1ValidationState());

  String? validate({
    required String? make,
    required String? model,
    required String? year,
    required String? trim,
    required String plateNo,
    required String odometer,
    required String vin,
    required String? specification,
    required String engineNo,
  }) {
    if (make == null || make.isEmpty) {
      state = CarDetails1ValidationState(errorMessage: "⚠️ Make is required");
      return state.errorMessage;
    } else if (model == null || model.isEmpty) {
      state = CarDetails1ValidationState(errorMessage: "⚠️ Model is required");
      return state.errorMessage;
    } else if (year == null || year.isEmpty) {
      state = CarDetails1ValidationState(errorMessage: "⚠️ Year is required");
      return state.errorMessage;
    } else if (trim == null || trim.isEmpty) {
      state = CarDetails1ValidationState(errorMessage: "⚠️ Trim is required");
      return state.errorMessage;
    } else if (plateNo.isEmpty) {
      state = CarDetails1ValidationState(errorMessage: "⚠️ Plate No is required");
      return state.errorMessage;
    } else if (odometer.isEmpty) {
      state = CarDetails1ValidationState(errorMessage: "⚠️ Odometer is required");
      return state.errorMessage;
    } else if (vin.isEmpty) {
      state = CarDetails1ValidationState(errorMessage: "⚠️ VIN is required");
      return state.errorMessage;
    } else if (specification == null || specification.isEmpty) {
      state = CarDetails1ValidationState(errorMessage: "⚠️ Specification is required");
      return state.errorMessage;
    } else if (engineNo.isEmpty) {
      state = CarDetails1ValidationState(errorMessage: "⚠️ Engine No is required");
      return state.errorMessage;
    }

    state = CarDetails1ValidationState(errorMessage: null);
    return null;
  }
}

final carDetails1ValidationProvider = StateNotifierProvider<
    CarDetails1ValidationNotifier, CarDetails1ValidationState>(
  (ref) => CarDetails1ValidationNotifier(),
);




class CarDetails2ValidationState {
  final String? errorMessage;
  CarDetails2ValidationState({this.errorMessage});
}

class CarDetails2ValidationNotifier
    extends StateNotifier<CarDetails2ValidationState> {
  CarDetails2ValidationNotifier() : super(CarDetails2ValidationState());

  String? validate({
    required String? bodyType,
    required String? color,
    required String cylinders,
    required String? fuelType,
    required String? transmission,
    required String option,
    required String carCondition,
    required String total,
    required String totalValue,
  }) {
      if (bodyType == null || bodyType.isEmpty) {
      state = CarDetails2ValidationState(errorMessage: "⚠️ Body Type is required");
      return state.errorMessage;
    } else if (color == null || color.isEmpty) {
      state = CarDetails2ValidationState(errorMessage: "⚠️ Color is required");
      return state.errorMessage;
    } else if (cylinders.isEmpty) {
      state = CarDetails2ValidationState(errorMessage: "⚠️ Cylinders is required");
      return state.errorMessage;
    } else if (fuelType == null || fuelType.isEmpty) {
      state = CarDetails2ValidationState(errorMessage: "⚠️ Fuel Type is required");
      return state.errorMessage;
    } else if (transmission == null || transmission.isEmpty) {
      state = CarDetails2ValidationState(errorMessage: "⚠️ Transmission is required");
      return state.errorMessage;
    } else if (option.isEmpty) {
      state = CarDetails2ValidationState(errorMessage: "⚠️ Second Color is required");
      return state.errorMessage;
    }  else if (carCondition.isEmpty) {
      state = CarDetails2ValidationState(errorMessage: "⚠️ Car Condition is required");
      return state.errorMessage;
    } else if (total.isEmpty) {
      state = CarDetails2ValidationState(errorMessage: "⚠️ Certificate Charges is required");
      return state.errorMessage;
    } else if (totalValue.isEmpty) {
      state = CarDetails2ValidationState(errorMessage: "⚠️ Total Value is required");
      return state.errorMessage;
    }

    state = CarDetails2ValidationState(errorMessage: null);
    return null;
  }
}

final carDetails2ValidationProvider = StateNotifierProvider<
    CarDetails2ValidationNotifier, CarDetails2ValidationState>(
  (ref) => CarDetails2ValidationNotifier(),
);





class CarImagesValidationState {
  final String? errorMessage;
  CarImagesValidationState({this.errorMessage});
}

class CarImagesValidationNotifier
    extends StateNotifier<CarImagesValidationState> {
  CarImagesValidationNotifier() : super(CarImagesValidationState());

  String? validate({
    String? img1,
    String? img2,
    String? img3,
    String? img4,
    String? img5,
    String? img6,
    String? img7,
    String? img8,
  }) {
    if (img1 == null || img1.isEmpty) {
      state = CarImagesValidationState(errorMessage: "⚠️ Front Image is required");
      return state.errorMessage;
    } else if (img2 == null || img2.isEmpty) {
      state = CarImagesValidationState(errorMessage: "⚠️ Back Image is required");
      return state.errorMessage;
    } else if (img3 == null || img3.isEmpty) {
      state = CarImagesValidationState(errorMessage: "⚠️ Clustermeter Image is required");
      return state.errorMessage;
    } else if (img4 == null || img4.isEmpty) {
      state = CarImagesValidationState(errorMessage: "⚠️ INTERIOR Image is required");
      return state.errorMessage;
    } else if (img5 == null || img5.isEmpty) {
      state = CarImagesValidationState(errorMessage: "⚠️ CHASSIS/VIN PLATE Image is required");
      return state.errorMessage;
    } else if (img6 == null || img6.isEmpty) {
      state = CarImagesValidationState(errorMessage: "⚠️ MULKIYA/POSSESSION Image is required");
      return state.errorMessage;
    } else if (img7 == null || img7.isEmpty) {
      state = CarImagesValidationState(errorMessage: "⚠️ Left Image is required");
      return state.errorMessage;
    } else if (img8 == null || img8.isEmpty) {
      state = CarImagesValidationState(errorMessage: "⚠️ Right Image is required");
      return state.errorMessage;
    }

    state = CarImagesValidationState(errorMessage: null);
    return null;
  }
}

final carImagesValidationProvider = StateNotifierProvider<
    CarImagesValidationNotifier, CarImagesValidationState>(
  (ref) => CarImagesValidationNotifier(),
);
