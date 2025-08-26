


class CarFormData {
  // Customer Details
  String? requestedFor;
  String? customerName;
  String? inspectionDate;
  String? address;
  String? evaluationNo;

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
  String? specification;
  String? bodyType;
  String? cylinders;
  String? transmission;
  String? carCondition;

  // Car Images (List of file paths or base64)
  String? carFrontImage; // uploaded front URL ya base64
  String? carBackImage;  // uploaded back URL ya base64

  CarFormData({
    this.requestedFor,
    this.customerName,
    this.inspectionDate,
    this.address,
    this.evaluationNo,
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
    this.specification,
    this.bodyType,
    this.cylinders,
    this.transmission,
    this.carCondition,
    this.carFrontImage,
    this.carBackImage,
  });

  Map<String, dynamic> toJson() {
    return {
      "requestedFor": requestedFor,
      "customer_name": customerName,
      "Invoice_Date": inspectionDate,
      "address": address,
      "evaluationNo": evaluationNo,
      "Make": make,
      "Model": model,
      "Year": year,
      "PlateNumber": plateNo,
      "vin_no": vin,
      "EngineNumber": engineNo,
      "Color": color,
      "fuel": fuelType,
      "options": option,
      "trim": trim,
      "Odometer": odometer,
      "specification": specification,
      "type": bodyType,
      "cylinders_no": cylinders,
      "transmission_type": transmission,
      "car_condition": carCondition,
      "carFrontImage": carFrontImage,
      "carBackImage": carBackImage,
    };
  }
}
