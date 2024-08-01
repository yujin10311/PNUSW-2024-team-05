import 'package:cloud_firestore/cloud_firestore.dart';
import 'shared_preferences_helper.dart';

class FirebaseHelper {
  // '시니어' 회원 정보 저장
  static Future<void> saveSenior(String uid) async {
    final prefs = await SharedPreferencesHelper.getAll();

    bool withPet = await SharedPreferencesHelper.getBool('_withPet') ?? false;
    bool withCam = await SharedPreferencesHelper.getBool('_withCam') ?? false;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final Map<String, dynamic> userData = {
      'username': prefs['_username'] ?? '',
      'email': prefs['_email'] ?? '',
      'password': prefs['_password'] ?? '',
      'memberType': prefs['_memberType'] ?? '',
      'isVerified': false,
      'age': prefs['_age'] ?? '',
      'gender': prefs['_gender'] ?? '',
      'phoneNum': prefs['_phoneNum'] ?? '',
      'phoneNum2': prefs['_phoneNum2'] ?? '',
      'city': prefs['_city'] ?? '',
      'gu': prefs['_gu'] ?? '',
      'dong': prefs['_dong'] ?? '',
      'symptom': prefs['_symptom'] ?? '',
      'withPet': withPet,
      'withCam': withCam,
      'activityType': prefs['_activityType'] ?? '',
      'dependentType': prefs['_dependentType'] ?? '',
      'walkingType': prefs['_walkingType'] ?? '',
      'symptomInfo': prefs['_symptomInfo'] ?? '',
      'petInfo': prefs['_petInfo'] ?? '',
      'addInfo': prefs['_addInfo'] ?? '',
      'rating': 0.0,
      'ratingCount': 0,
    };

    await firestore.collection('user').doc(uid).set(userData);
  }

  // '메이트' 회원 정보 저장
  static Future<void> saveMate(String uid) async {
    final prefs = await SharedPreferencesHelper.getAll();

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final Map<String, dynamic> userData = {
      'username': prefs['_username'] ?? '',
      'email': prefs['_email'] ?? '',
      'password': prefs['_password'] ?? '',
      'memberType': prefs['_memberType'] ?? '',
      'isVerified': false,
      'phoneNum': prefs['_phoneNum'] ?? '',
      'age': prefs['_age'] ?? '',
      'gender': prefs['_gender'] ?? '',
      'city': prefs['_city'] ?? '',
      'gu': prefs['_gu'] ?? '',
      'dong': prefs['_dong'] ?? '',
      'activityType': prefs['_activityType'] ?? '',
      'dayTime': prefs['_dayTime'] ?? '',
      'residentCert': false,
      'schoolCert': false,
      'addInfo': prefs['_addInfo'] ?? '',
      'credit': 0,
      'rating': 0.0,
      'ratingCount': 0,
    };

    await firestore.collection('user').doc(uid).set(userData);
  }

  // 기간과 지역에 따라 포스트카드 쿼리(홍 화면 전용)
  static Future<List<Map<String, dynamic>>> queryPostcardsByDurLocStat(
      DateTime startTime,
      DateTime endTime,
      String dong,
      String sortBy,
      String status) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    DateTime startOfDay =
        DateTime(startTime.year, startTime.month, startTime.day);
    DateTime endOfDay =
        DateTime(endTime.year, endTime.month, endTime.day, 23, 59, 59, 999);

    Query postsQuery = firestore
        .collection('posts')
        .where('startTime',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('startTime', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .where('dong', isEqualTo: dong)
        .where('status', isEqualTo: status);

    QuerySnapshot postsSnapshot = await postsQuery.get();

    List<Map<String, dynamic>> results = [];

    for (var postDoc in postsSnapshot.docs) {
      var postData = postDoc.data() as Map<String, dynamic>;
      var seniorUid = postData['seniorUid'];

      DocumentSnapshot userSnapshot =
          await firestore.collection('user').doc(seniorUid).get();

      if (userSnapshot.exists) {
        var userData = userSnapshot.data() as Map<String, dynamic>;

        results.add({
          'seniorUid': seniorUid,
          'seniorName': userData['username'] ?? '',
          'rating': userData['rating'] ?? 0.0,
          'ratingCount': userData['ratingCount'] ?? 0,
          'dependentType': userData['dependentType'] ?? '',
          'withPet': userData['withPet'] ?? false,
          'withCam': userData['withCam'] ?? false,
          'symptom': userData['symptom']?.cast<String>() ?? [],
          'walkingType': userData['walkingType'] ?? '',
          'petInfo': userData['petInfo'] ?? '',
          'symptomInfo': userData['symptomInfo'] ?? '',
          'postId': postDoc.id,
          'city': postData['city'] ?? '', // 시
          'gu': postData['gu'] ?? '', // 구
          'dong': postData['dong'] ?? '', // 동
          'status': postData['status'] ?? '', // posted
          'activityType': postData['activityType'] ?? '',
          'startTime': (postData['startTime'] as Timestamp).toDate(),
          'endTime': (postData['endTime'] as Timestamp).toDate(),
        });
      }
    }

    print('Fetched ${results.length} posts:');
    for (var result in results) {
      print('--- Post ---');
      result.forEach((key, value) {
        print('$key: $value\n');
      });
    }

    if (sortBy == "오름차순") {
      results.sort((a, b) => a['startTime'].compareTo(b['startTime']));
    } else if (sortBy == "내림차순") {
      results.sort((a, b) => b['startTime'].compareTo(a['startTime']));
    }

    return results;
  }
}
