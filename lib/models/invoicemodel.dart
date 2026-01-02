import 'package:project/models/carfoammodel.dart';

class Invoice {
  final String id;
  final String code;
  final String applicationNo;
  final String invoiceDate;
  final String fuel;
  final String? requestedFor;
  final String? bankRef;
  final String make;
  final String makeImage;
  final String model;
  final String type;
  final String year;
  final String odometer;
  final String odometerUnit;
  final String plateNumber;
  final String engineNumber;
  final String total;
  final String totalValue;
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
  final String? statusAction;
  final String? bankName;
  final String? customer_email;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? image6;
  String? image7;
  String? image8;

  Invoice({
    required this.id,
    required this.code,
    required this.applicationNo,
    required this.invoiceDate,
    required this.fuel,
    this.requestedFor,
    this.bankRef,
    required this.make,
    required this.makeImage,
    required this.model,
    required this.type,
    required this.year,
    required this.odometer,
    required this.odometerUnit,
    required this.plateNumber,
    required this.engineNumber,
    required this.total,
    required this.totalValue,
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
    this.statusAction,
    this.bankName,
    this.customer_email,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.image6,
    this.image7,
    this.image8,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      applicationNo: json['ApplicationNo'] ?? '',
      invoiceDate: json['Invoice_Date'] ?? '',
      fuel: json['fuel'] ?? '',
      requestedFor: json['requested_for'],
      bankRef: json['bank_Reference'],
      make: json['Make'] ?? '',
      makeImage: json['Make_image'] ?? '',
      model: json['Model'] ?? '',
      type: json['type'] ?? '',
      year: json['Year'] ?? '',
      odometer: json['Odometer'] ?? '',
      odometerUnit: json['OdometerUnit'] ?? '',
      plateNumber: json['PlateNumber'] ?? '',
      engineNumber: json['EngineNumber'] ?? '',
      total: json['Total'] ?? '',
      totalValue: json['TotalValue'] ?? '',
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
      statusAction: json['action_status'],
      bankName: json['BankName'],
      customer_email: json['customer_email'],
      image1: json['image1'],
      image2: json['image2'],
      image3: json['image3'],
      image4: json['image4'],
      image5: json['image5'],
      image6: json['image6'],
      image7: json['image7'],
      image8: json['image8'],
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
      "bank_Reference": bankRef,
      "Make": make,
      "Make_image": make,
      "Model": model,
      "type": type,
      "Year": year,
      "Odometer": odometer,
      "OdometerUnit": odometerUnit,
      "PlateNumber": plateNumber,
      "EngineNumber": engineNumber,
      "Total": total,
      "TotalValue": totalValue,
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
      "action_status": statusAction,
      "BankName": bankName,
      "customer_email": customer_email,
      "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5": image5,
    "image6": image6,
    "image7": image7,
    "image8": image8,
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


