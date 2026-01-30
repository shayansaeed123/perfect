

class ChargesModel {
  final int charges;

  ChargesModel({required this.charges});

  factory ChargesModel.fromJson(Map<String, dynamic> json) {
    return ChargesModel(
      charges: json['charges'],
    );
  }
}


  class TotalChargesModel {
    final int TotalCharges;

    TotalChargesModel({required this.TotalCharges});

    factory TotalChargesModel.fromJson(Map<String, dynamic> json) {
      return TotalChargesModel(
        TotalCharges: json['total_charges'],
      );
    }
  }