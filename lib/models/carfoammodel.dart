


class CarFormData {
  // Customer Details
  String? requestedFor;
  String? customerName;
  String? inspectionDate;
  String? address;
  // String? evaluationNo;
  String? bankName;
  String? customerEmail;
  String? total;
  String? bankRef;
  String? general_email;
  String? amount_without_tax;

  // Car Details 1
  String? make;
  String? model;
  String? year;
  String? trim;
  String? plateNo;
  String? odometer;
  String? odometerUnit;
  String? vin;
  String? specification;
  String? engineNo;
  
  
  

  // Car Details 2
  String? bodyType;
  String? color;
  String? cylinders;
  String? fuelType;
  String? transmission;
  String? option;
  String? carCondition;
  String? totalValue;
  String? comments;
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
    // this.evaluationNo,
    this.bankName,
    this.customerEmail,
    this.bankRef,
    this.general_email,
    this.amount_without_tax,
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
    this.totalValue,
    this.comments,
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
    // String? evaluationNo,
    String? bankName,
    String? customerEmail,
    String? bankRef,
    String? general_email,
    String? amount_without_tax,
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
    String? totalValue,
    String? comments,
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
      // evaluationNo: evaluationNo ?? this.evaluationNo,
      bankName: bankName ?? this.bankName,
      customerEmail: customerEmail ?? this.customerEmail,
      bankRef: bankRef ?? this.bankRef,
      general_email: general_email ?? this.general_email,
      amount_without_tax: amount_without_tax ?? this.amount_without_tax,
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
      totalValue: totalValue ?? this.totalValue,
      comments: comments ?? this.comments,
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
    "customer_email": customerEmail ?? "",
    "Invoice_Date": inspectionDate ?? "",
    "address": address ?? "",
    "bank_Reference": bankRef ?? "",
    "general_email": general_email ?? "",
    "amount_without_tax": amount_without_tax ?? "",
    // "ApplicationNo": evaluationNo ?? "",
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
    "TotalValue": totalValue ?? "",
    "comments": comments ?? "",
    "enterby": enterby ?? "",
    "profile_image1": profile_image1 ?? "",
    "profile_image2": profile_image2 ?? "",
    "profile_image3": profile_image3 ?? "",
    "profile_image4": profile_image4 ?? "",
    "profile_image5": profile_image5 ?? "",
    "profile_image6": profile_image6 ?? "",
    "profile_image7": profile_image7 ?? "",
    "profile_image8": profile_image8 ?? "",
  };
}
}
