import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class MySharedPrefrence {
  static final GetStorage _box = GetStorage('values');
  static final ValueNotifier<bool> themeNotifier =
      ValueNotifier(_box.read<bool>('isDarkMode') ?? false);

  static MySharedPrefrence? _instance;

  MySharedPrefrence._();
  
  factory MySharedPrefrence() {
    _instance ??= MySharedPrefrence._();
    return _instance!;
  }

  
  bool getUserLoginStatus() {
    return _box.read<bool>('user_login_status') ?? false;
  }


  void setUserLoginStatus(bool status) {
    _box.write('user_login_status', status);
  }

  
  String get_user_id() {
    return _box.read<String>('user_id') ?? '';
  }

  void set_user_id(String userId) {
    _box.write('user_id', userId);
  }

  String get_designation_id() {
    return _box.read<String>('designation_id') ?? '';
  }

  void set_designation_id(String designationId) {
    _box.write('designation_id', designationId);
  }

  String get_hospital_id() {
    return _box.read<String>('hospital_id') ?? '';
  }

  void set_hospital_id(String hospitalid) {
    _box.write('hospital_id', hospitalid);
  }

  String get_user_name() {
    return _box.read<String>('user_name') ?? '';
  }

  void set_user_name(String userName) {
    _box.write('user_name', userName);
  }


  String get_user_image() {
    return _box.read<String>('image') ?? '';
  }

  void set_user_image(String image) {
    _box.write('image', image);
  }


  String get_user_email() {
    return _box.read<String>('email') ?? '';
  }

  void set_user_email(String email) {
    _box.write('email', email);
  }


    String get_user_gender() {
    return _box.read<String>('gender') ?? '';
  }

  void set_user_gender(String gender) {
    _box.write('gender', gender);
  }


    String get_user_contact() {
    return _box.read<String>('contact') ?? '';
  }

  void set_user_contact(String contact) {
    _box.write('contact', contact);
  }



    String get_user_fullcode() {
    return _box.read<String>('full_code') ?? '';
  }

  void set_user_fullcode(String contact) {
    _box.write('full_code', contact);
  }


  void logout() {
    _box.erase();
  }

  bool isDarkMode() {
    return _box.read<bool>('isDarkMode') ?? false;
  }

  void setDarkMode(bool isDark) {
    _box.write('isDarkMode', isDark);
    themeNotifier.value = isDark; 
  }
}