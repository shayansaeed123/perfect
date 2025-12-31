


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:project/models/carfoammodel.dart';

class TextFieldController extends GetxController {
  final TextEditingController _emailCon = TextEditingController();
  TextEditingController get emailCon => _emailCon;

  final TextEditingController _loginPassCon = TextEditingController();
  TextEditingController get loginPassCon => _loginPassCon;

final TextEditingController _requested = TextEditingController();
  TextEditingController get requested => _requested;


  final TextEditingController _customerName = TextEditingController();
  TextEditingController get customerName => _customerName;

  final TextEditingController _inspectiondate = TextEditingController();
  TextEditingController get inspectiondate => _inspectiondate;

  final TextEditingController _address = TextEditingController();
  TextEditingController get address => _address;

  final TextEditingController _evaluationNo = TextEditingController();
  TextEditingController get evaluationNo => _evaluationNo;

  final TextEditingController _option = TextEditingController();
  TextEditingController get option => _option;

  final TextEditingController _trim = TextEditingController();
  TextEditingController get trim => _trim;

  final TextEditingController _plateNo = TextEditingController();
  TextEditingController get plateNo => _plateNo;

  final TextEditingController _vin = TextEditingController();
  TextEditingController get vin => _vin;

  final TextEditingController _engineNo = TextEditingController();
  TextEditingController get engineNo => _engineNo;

  final TextEditingController _odometer = TextEditingController();
  TextEditingController get odometer => _odometer;
  
  final TextEditingController _cylinders = TextEditingController();
  TextEditingController get cylinders => _cylinders;

  final TextEditingController _tranmission = TextEditingController();
  TextEditingController get tranmission => _tranmission;

  final TextEditingController _condition = TextEditingController();
  TextEditingController get condition => _condition;

  final TextEditingController _carCondition = TextEditingController();
  TextEditingController get carCondition => _carCondition;

  final TextEditingController _total = TextEditingController();
  TextEditingController get total => _total;

  final TextEditingController _totalValue = TextEditingController();
  TextEditingController get totalValue => _totalValue;

  final TextEditingController _search = TextEditingController();
  TextEditingController get search => _search;

  final TextEditingController _EditProfileName = TextEditingController();
  TextEditingController get EditProfileName => _EditProfileName;

  final TextEditingController _Wallet = TextEditingController();
  TextEditingController get Wallet => _Wallet;

  final TextEditingController _Discount = TextEditingController();
  TextEditingController get Discount => _Discount;

  final TextEditingController _Complaintmessage = TextEditingController();
  TextEditingController get Complaintmessage => _Complaintmessage;

  final TextEditingController _MessageCafe = TextEditingController();
  TextEditingController get MessageCafe => _MessageCafe;

  final TextEditingController _Specialinstructions = TextEditingController();
  TextEditingController get Specialinstructions => _Specialinstructions;

  final TextEditingController _contactUsName = TextEditingController();
  TextEditingController get contactUsName => _contactUsName;

  final TextEditingController _contactUsemail = TextEditingController();
  TextEditingController get contactUsemail => _contactUsemail;

  final TextEditingController _contactUsphone = TextEditingController();
  TextEditingController get contactUsphone => _contactUsphone;

  final TextEditingController _feedback = TextEditingController();
  TextEditingController get feedback => _feedback;

  final TextEditingController _oldPass = TextEditingController();
  TextEditingController get oldPass => _oldPass;

  final TextEditingController _newPass = TextEditingController();
  TextEditingController get newPass => _newPass;

  final TextEditingController _conPass = TextEditingController();
  TextEditingController get conPass => _conPass;

  final TextEditingController _searchConAll = TextEditingController();
  TextEditingController get searchConAll => _searchConAll;

  final TextEditingController _searchConPre = TextEditingController();
  TextEditingController get searchConPre => _searchConPre;


  ///Account Details 

final TextEditingController _title = TextEditingController();
  TextEditingController get title => _title;

  final TextEditingController _bankname = TextEditingController();
  TextEditingController get bankname => _bankname;

  final TextEditingController _branchcode = TextEditingController();
  TextEditingController get branchcode => _branchcode;

  final TextEditingController _accountnumber = TextEditingController();
  TextEditingController get accountnumber => _accountnumber;

  final TextEditingController _ibannumber = TextEditingController();
  TextEditingController get ibannumber => _ibannumber;

  final TextEditingController _accounttitle = TextEditingController();
  TextEditingController get accounttitle => _accounttitle;

  final TextEditingController _mobilenumber = TextEditingController();
  TextEditingController get mobilenumber => _mobilenumber;

  final TextEditingController _wallet = TextEditingController();
  TextEditingController get wallet => _wallet;

  final TextEditingController _bankRef = TextEditingController();
  TextEditingController get bankRef => _bankRef;

  final TextEditingController _customerEmail = TextEditingController();
  TextEditingController get customerEmail => _customerEmail;



  final TextEditingController _furtherInfo = TextEditingController();
  TextEditingController get furtherInfo => _furtherInfo;


  // ✅ Ye method banado
  void clearAll() {
    requested.clear();
    customerName.clear();
    inspectiondate.clear();
    address.clear();
    evaluationNo.clear();

    plateNo.clear();
    vin.clear();
    engineNo.clear();
    option.clear();
    trim.clear();
    odometer.clear();
    cylinders.clear();
    tranmission.clear();
    customerEmail.clear();
    total.clear();
    totalValue.clear();
    carCondition.clear();
    
  }

}

TextFieldController reusabletextfieldcontroller =
    Get.put(TextFieldController());



