class Invoice {
  final String id;
  final String code;
  final String applicationNo;
  final String invoiceDate;
  final String fuel;
  final String? requestedFor;
  final String make;
  final String model;
  final String type;
  final String year;
  final String odometer;
  final String plateNumber;
  final String engineNumber;
  final String total;
  final String color;
  final String? customerName;
  final String? address;
  final String? vinNo;
  final String? cylindersNo;
  final String? transmissionType;
  final String? options;
  final String? carCondition;
  final String trim;
  final String specification;
  final String enterBy;

  Invoice({
    required this.id,
    required this.code,
    required this.applicationNo,
    required this.invoiceDate,
    required this.fuel,
    this.requestedFor,
    required this.make,
    required this.model,
    required this.type,
    required this.year,
    required this.odometer,
    required this.plateNumber,
    required this.engineNumber,
    required this.total,
    required this.color,
    this.customerName,
    this.address,
    this.vinNo,
    this.cylindersNo,
    this.transmissionType,
    this.options,
    this.carCondition,
    required this.trim,
    required this.specification,
    required this.enterBy,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      applicationNo: json['ApplicationNo'] ?? '',
      invoiceDate: json['Invoice_Date'] ?? '',
      fuel: json['fuel'] ?? '',
      requestedFor: json['requested_for'],
      make: json['Make'] ?? '',
      model: json['Model'] ?? '',
      type: json['type'] ?? '',
      year: json['Year'] ?? '',
      odometer: json['Odometer'] ?? '',
      plateNumber: json['PlateNumber'] ?? '',
      engineNumber: json['EngineNumber'] ?? '',
      total: json['Total'] ?? '',
      color: json['Color'] ?? '',
      customerName: json['customer_name'],
      address: json['address'],
      vinNo: json['vin_no'],
      cylindersNo: json['cylinders_no'],
      transmissionType: json['transmission_type'],
      options: json['options'],
      carCondition: json['car_condition'],
      trim: json['trim'] ?? '',
      specification: json['specification'] ?? '',
      enterBy: json['enterby'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "code": code,
      "ApplicationNo": applicationNo,
      "Invoice_Date": invoiceDate,
      "fuel": fuel,
      "requested_for": requestedFor,
      "Make": make,
      "Model": model,
      "type": type,
      "Year": year,
      "Odometer": odometer,
      "PlateNumber": plateNumber,
      "EngineNumber": engineNumber,
      "Total": total,
      "Color": color,
      "customer_name": customerName,
      "address": address,
      "vin_no": vinNo,
      "cylinders_no": cylindersNo,
      "transmission_type": transmissionType,
      "options": options,
      "car_condition": carCondition,
      "trim": trim,
      "specification": specification,
      "enterby": enterBy,
    };
  }
}
