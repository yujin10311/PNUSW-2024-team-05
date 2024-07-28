import 'package:cloud_firestore/cloud_firestore.dart';
import 'shared_preferences_helper.dart';

class FirebaseHelper {
  // '시니어' 회원 정보 저장
  static Future<void> saveSenior(String uid) async {
    // SharedPreferences에서 모든 데이터 가져오기
    final prefs = await SharedPreferencesHelper.getAll();

    // '_isVerified', '_withPet', '_withCam' 값을 불러오기
    bool isVerified =
        await SharedPreferencesHelper.getBool('_isVerified') ?? false;
    bool withPet = await SharedPreferencesHelper.getBool('_withPet') ?? false;
    bool withCam = await SharedPreferencesHelper.getBool('_withCam') ?? false;

    // Firestore 인스턴스 가져오기
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 데이터 구성
    final Map<String, dynamic> userData = {
      'memberType': prefs['_memberType'],
      'username': prefs['_username'],
      'isVerified': isVerified,
      'email': prefs['_email'],
      'password': prefs['_password'],
      'phoneNum': prefs['_phoneNum'],
      'phoneNum2': prefs['_phoneNum2'],
      'age': prefs['_age'],
      'gender': prefs['_gender'],
      'city': prefs['_city'],
      'gu': prefs['_gu'],
      'dong': prefs['_dong'],
      'activityType': prefs['_activityType'],
      'dependentType': prefs['_dependentType'],
      'withPet': withPet,
      'petInfo': prefs['_petInfo'],
      'withCam': withCam,
      'symptom': prefs['_symptom'],
      'symptomInfo': prefs['_symptomInfo'],
      'walkingType': prefs['_walkingType'],
      'addInfo': prefs['_addInfo'],
    };

    // Firestore에 유저 데이터 저장
    await firestore.collection('user').doc(uid).set(userData);
  }

  // '메이트' 회원 정보 저장
  static Future<void> saveMate(String uid) async {
    // SharedPreferences에서 모든 데이터 가져오기
    final prefs = await SharedPreferencesHelper.getAll();

    // '_isVerified' 값을 불러오기
    bool isVerified =
        await SharedPreferencesHelper.getBool('_isVerified') ?? false;

    // Firestore 인스턴스 가져오기
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 데이터 구성
    final Map<String, dynamic> userData = {
      'memberType': prefs['_memberType'],
      'username': prefs['_username'],
      'isVerified': isVerified,
      'email': prefs['_email'],
      'password': prefs['_password'],
      'phoneNum': prefs['_phoneNum'],
      'age': prefs['_age'],
      'gender': prefs['_gender'],
      'city': prefs['_city'],
      'gu': prefs['_gu'],
      'dong': prefs['_dong'],
      'activityType': prefs['_activityType'],
      'dayTime': prefs['_dayTime'],
      'addInfo': prefs['_addInfo'],
    };

    // Firestore에 유저 데이터 저장
    await firestore.collection('user').doc(uid).set(userData);
  }
}
