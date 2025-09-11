


class CarFormData {
  // Customer Details
  String? requestedFor;
  String? customerName;
  String? inspectionDate;
  String? address;
  String? evaluationNo;
  String? bankName;

  // Car Details 1
  String? make;
  String? model;
  String? year;
  String? plateNo;
  String? vin;
  String? engineNo;
  String? color;
  String? fuelType;
  String? option;

  // Car Details 2
  String? trim;
  String? odometer;
  String? odometerUnit;
  String? specification;
  String? bodyType;
  String? cylinders;
  String? transmission;
  String? carCondition;
  String? total;
  String? enterby;

  // Car Images (List of file paths or base64)
  String? profile_image1; // uploaded front URL ya base64
  String? profile_image2; // uploaded front URL ya base64
  String? profile_image3; // uploaded front URL ya base64
  String? profile_image4; // uploaded front URL ya base64
  String? profile_image5; // uploaded front URL ya base64
  String? profile_image6; // uploaded front URL ya base64
  String? profile_image7; // uploaded front URL ya base64
  String? profile_image8; // uploaded front URL ya base64

  CarFormData({
    this.requestedFor,
    this.customerName,
    this.inspectionDate,
    this.address,
    this.evaluationNo,
    this.bankName,
    this.make,
    this.model,
    this.year,
    this.plateNo,
    this.vin,
    this.engineNo,
    this.color,
    this.fuelType,
    this.option,
    this.trim,
    this.odometer,
    this.odometerUnit,
    this.specification,
    this.bodyType,
    this.cylinders,
    this.transmission,
    this.carCondition,
    this.total,
    this.enterby,
    this.profile_image1,
    this.profile_image2,
    this.profile_image3,
    this.profile_image4,
    this.profile_image5,
    this.profile_image6,
    this.profile_image7,
    this.profile_image8,
  });

  CarFormData copyWith({
    String? requestedFor,
    String? customerName,
    String? inspectionDate,
    String? address,
    String? evaluationNo,
    String? bankName,
    String? make,
    String? model,
    String? year,
    String? plateNo,
    String? vin,
    String? engineNo,
    String? color,
    String? fuelType,
    String? option,
    String? trim,
    String? odometer,
    String? odometerUnit,
    String? specification,
    String? bodyType,
    String? cylinders,
    String? transmission,
    String? carCondition,
    String? total,
    String? enterby,
    String? profile_image1,
    String? profile_image2,
    String? profile_image3,
    String? profile_image4,
    String? profile_image5,
    String? profile_image6,
    String? profile_image7,
    String? profile_image8,
  }) {
    return CarFormData(
      requestedFor: requestedFor ?? this.requestedFor,
      customerName: customerName ?? this.customerName,
      inspectionDate: inspectionDate ?? this.inspectionDate,
      address: address ?? this.address,
      evaluationNo: evaluationNo ?? this.evaluationNo,
      bankName: bankName ?? this.bankName,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      plateNo: plateNo ?? this.plateNo,
      vin: vin ?? this.vin,
      engineNo: engineNo ?? this.engineNo,
      color: color ?? this.color,
      fuelType: fuelType ?? this.fuelType,
      option: option ?? this.option,
      trim: trim ?? this.trim,
      odometer: odometer ?? this.odometer,
      odometerUnit: odometerUnit ?? this.odometerUnit,
      specification: specification ?? this.specification,
      bodyType: bodyType ?? this.bodyType,
      cylinders: cylinders ?? this.cylinders,
      transmission: transmission ?? this.transmission,
      carCondition: carCondition ?? this.carCondition,
      total: total ?? this.total,
      enterby: enterby ?? this.enterby,
      profile_image1: profile_image1 ?? this.profile_image1,
      profile_image2: profile_image2 ?? this.profile_image2,
      profile_image3: profile_image3 ?? this.profile_image3,
      profile_image4: profile_image4 ?? this.profile_image4,
      profile_image5: profile_image5 ?? this.profile_image5,
      profile_image6: profile_image6 ?? this.profile_image6,
      profile_image7: profile_image7 ?? this.profile_image7,
      profile_image8: profile_image8 ?? this.profile_image8,
    );
  }

  Map<String, dynamic> toJson() {
  return {
    "BankName": bankName ?? "",
    "requested_for": requestedFor ?? "",
    "customer_name": customerName ?? "",
    "Invoice_Date": inspectionDate ?? "",
    "address": address ?? "",
    "ApplicationNo": evaluationNo ?? "",
    "Make": make ?? "",
    "Model": model ?? "",
    "Year": year ?? "",
    "PlateNumber": plateNo ?? "",
    "vin_no": vin ?? "",
    "EngineNumber": engineNo ?? "",
    "Color": color ?? "",
    "fuel": fuelType ?? "",
    "options": option ?? "",
    "trim": trim ?? "",
    "Odometer": odometer ?? "",
    "OdometerUnit": odometerUnit ?? "",
    "specification": specification ?? "",
    "type": bodyType ?? "",
    "cylinders_no": cylinders ?? "",
    "transmission_type": transmission ?? "",
    "car_condition": carCondition ?? "",
    "Total": total ?? "",
    "enterby": enterby ?? "",
    "profile_image1": profile_image1 ?? "",
    "profile_image2": profile_image2 ?? "",
    "profile_image3": profile_image3 ?? "",
    "profile_image4": profile_image4 ?? "",
    "profile_image5": profile_image5 ?? "",
    "profile_image6": profile_image6 ?? "",
    "profile_image7": profile_image7 ?? "",
    "profile_image8": profile_image8 ?? "",
    // "image1": profile_image1 ?? "",
    // "image2": profile_image2 ?? "",
    // "image3": profile_image3 ?? "",
    // "image4": profile_image4 ?? "",
    // "image5": profile_image5 ?? "",
    // "image6": profile_image6 ?? "",
    // "image7": profile_image7 ?? "",
    // "image8": profile_image8 ?? "",
  };
}
}
