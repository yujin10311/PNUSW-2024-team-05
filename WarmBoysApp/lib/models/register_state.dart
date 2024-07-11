import 'package:flutter/material.dart';

class RegisterState with ChangeNotifier {
  // Page 1 fields
  String name = '';
  String age = '';
  String gender = '남성';
  String type = '청년';
  String contact = '';
  String dong = '부산 금정구 동1';
  String address2 = '';
  String university = '';
  String guardianContact = '';

  // Page 2 fields
  String id = '';
  String password = '';
  String confirmPassword = '';
  String email = '';

  bool get isFormValid {
    bool page1Valid = name.isNotEmpty &&
        age.isNotEmpty &&
        contact.isNotEmpty &&
        address2.isNotEmpty;
    if (type == '청년') {
      page1Valid = page1Valid && university.isNotEmpty;
    }
    if (type == '노인') {
      page1Valid = page1Valid && guardianContact.isNotEmpty;
    }

    bool page2Valid = id.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        email.isNotEmpty;
    bool passwordsMatch = password == confirmPassword;

    return page1Valid && page2Valid && passwordsMatch;
  }

  void updateField(String key, String value) {
    switch (key) {
      case 'name':
        name = value;
        break;
      case 'age':
        age = value;
        break;
      case 'gender':
        gender = value;
        break;
      case 'type':
        type = value;
        break;
      case 'contact':
        contact = value;
        break;
      case 'dong':
        dong = value;
        break;
      case 'address2':
        address2 = value;
        break;
      case 'university':
        university = value;
        break;
      case 'guardianContact':
        guardianContact = value;
        break;
      case 'id':
        id = value;
        break;
      case 'password':
        password = value;
        break;
      case 'confirmPassword':
        confirmPassword = value;
        break;
      case 'email':
        email = value;
        break;
    }
    notifyListeners();
  }

  void reset() {
    name = '';
    age = '';
    gender = '남성';
    type = '청년';
    contact = '';
    dong = '부산 금정구 동1';
    address2 = '';
    university = '';
    guardianContact = '';
    id = '';
    password = '';
    confirmPassword = '';
    email = '';
    notifyListeners();
  }

  void clearField(String key) {
    updateField(key, '');
  }
}
