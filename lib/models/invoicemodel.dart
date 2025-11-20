import 'package:project/models/carfoammodel.dart';

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
  final String? status_name;
  final String? bankName;
  CarFormData data;

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
    this.status_name,
    this.bankName,
    required this.data
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
      status_name: json['status_name'],
      bankName: json['BankName'],

      data: CarFormData(
        requestedFor: json["requested_for"],
        customerName: json["customer_name"],
        inspectionDate: json["Invoice_Date"],
        address: json["address"],
        bankName: json["BankName"],

        make: json["Make"],
        model: json["Model"],
        year: json["Year"],
        trim: json["trim"],
        plateNo: json["PlateNumber"],
        odometer: json["Odometer"],
        odometerUnit: json["OdometerUnit"],
        vin: json["vin_no"],
        specification: json["specification"],
        engineNo: json["EngineNumber"],

        bodyType: json["type"],
        color: json["Color"],
        cylinders: json["cylinders_no"],
        fuelType: json["fuel"],
        transmission: json["transmission_type"],
        option: json["options"],
        carCondition: json["car_condition"],
        total: json["Total"],
        enterby: json["enterby"],

        profile_image1: json["image1"],
        profile_image2: json["image2"],
        profile_image3: json["image3"],
        profile_image4: json["image4"],
        profile_image5: json["image5"],
        profile_image6: json["image6"],
        profile_image7: json["image7"],
        profile_image8: json["image8"],
      ),
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
      "status_name": status_name,
      "BankName": bankName,
    };
  }
}


class InvoiceFilter {
  final String dateRange;
  final String text;
  final String actionStatus;
  final String enterBy;

  InvoiceFilter({
    required this.dateRange,
    required this.text,
    required this.actionStatus,
    required this.enterBy,
  });

  Map<String, dynamic> toJson() {
    return {
      "daterange": dateRange,
      "text": text,
      "action_status": actionStatus,
      "enterby": enterBy,
    };
  }

  InvoiceFilter copyWith({
    String? dateRange,
    String? text,
    String? actionStatus,
    String? enterBy,
  }) {
    return InvoiceFilter(
      dateRange: dateRange ?? this.dateRange,
      text: text ?? this.text,
      actionStatus: actionStatus ?? this.actionStatus,
      enterBy: enterBy ?? this.enterBy,
    );
  }
}


