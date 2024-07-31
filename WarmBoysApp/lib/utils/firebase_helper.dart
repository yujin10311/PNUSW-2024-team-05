import 'package:cloud_firestore/cloud_firestore.dart';
import 'shared_preferences_helper.dart';

class FirebaseHelper {
  // '시니어' 회원 정보 저장
  static Future<void> saveSenior(String uid) async {
    // SharedPreferences에서 모든 데이터 가져오기
    final prefs = await SharedPreferencesHelper.getAll();

    // '_withPet', '_withCam' 값을 불러오기
    bool withPet = await SharedPreferencesHelper.getBool('_withPet') ?? false;
    bool withCam = await SharedPreferencesHelper.getBool('_withCam') ?? false;

    // Firestore 인스턴스 가져오기
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 데이터 구성
    final Map<String, dynamic> userData = {
      'username': prefs['_username'],
      'email': prefs['_email'],
      'password': prefs['_password'],
      'memberType': prefs['_memberType'],
      'isVerified': false,
      'age': prefs['_age'],
      'gender': prefs['_gender'],
      'phoneNum': prefs['_phoneNum'],
      'phoneNum2': prefs['_phoneNum2'],
      'city': prefs['_city'],
      'gu': prefs['_gu'],
      'dong': prefs['_dong'],
      'symptom': prefs['_symptom'],
      'withPet': withPet,
      'withCam': withCam,
      'activityType': prefs['_activityType'],
      'dependentType': prefs['_dependentType'],
      'walkingType': prefs['_walkingType'],
      'symptomInfo': prefs['_symptomInfo'],
      'petInfo': prefs['_petInfo'],
      'addInfo': prefs['_addInfo'],
      'rating': 0.0,
    };

    // Firestore에 유저 데이터 저장
    await firestore.collection('user').doc(uid).set(userData);
  }

  // '메이트' 회원 정보 저장
  static Future<void> saveMate(String uid) async {
    // SharedPreferences에서 모든 데이터 가져오기
    final prefs = await SharedPreferencesHelper.getAll();

    // Firestore 인스턴스 가져오기
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 데이터 구성
    final Map<String, dynamic> userData = {
      'username': prefs['_username'],
      'email': prefs['_email'],
      'password': prefs['_password'],
      'memberType': prefs['_memberType'],
      'isVerified': false,
      'phoneNum': prefs['_phoneNum'],
      'age': prefs['_age'],
      'gender': prefs['_gender'],
      'city': prefs['_city'],
      'gu': prefs['_gu'],
      'dong': prefs['_dong'],
      'activityType': prefs['_activityType'],
      'dayTime': prefs['_dayTime'],
      'residentCert': false,
      'schoolCert': false,
      'addInfo': prefs['_addInfo'],
      'credit': 0,
      'rating': 0.0,
    };

    // Firestore에 유저 데이터 저장
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

    // 날짜의 시간을 0으로 설정하여 날짜만 비교하도록 함
    DateTime startOfDay =
        DateTime(startTime.year, startTime.month, startTime.day);
    DateTime endOfDay =
        DateTime(endTime.year, endTime.month, endTime.day, 23, 59, 59, 999);

    // Firestore 쿼리 생성
    Query postsQuery = firestore
        .collection('posts')
        .where('startTime',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('startTime', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .where('dong', isEqualTo: dong)
        .where('status', isEqualTo: status);

    // 쿼리 실행
    QuerySnapshot postsSnapshot = await postsQuery.get();

    // 결과 리스트 초기화
    List<Map<String, dynamic>> results = [];

    // 각 포스트 문서 처리
    for (var postDoc in postsSnapshot.docs) {
      var postData = postDoc.data() as Map<String, dynamic>;
      var seniorUid = postData['seniorUid'];

      // 유저 컬렉션에서 시니어 UID를 통해 사용자 정보 가져오기
      DocumentSnapshot userSnapshot =
          await firestore.collection('user').doc(seniorUid).get();

      if (userSnapshot.exists) {
        var userData = userSnapshot.data() as Map<String, dynamic>;

        // 데이터 구성: 홈 화면의 공고 카드에 보내주는 정보들
        results.add({
          'postId': postDoc.id,
          'seniorUid': seniorUid, // 작성자 uid(노인)
          'city': userData['city'], // 시
          'gu': userData['gu'], // 구
          'postDong': postData['dong'], // 동
          'postStatus': postData['status'], // posted
          'username': userData['username'],
          'startTime': postData['startTime'],
          'endTime': postData['endTime'],
          'dong': userData['dong'],
          'rating': userData['rating'],
          'ratingCount': userData['ratingCount'],
        });
      }
    }

    // 쿼리 결과 로그 출력
    print('Fetched ${results.length} posts:');
    for (var result in results) {
      print(result);
    }

    // 정렬 조건에 따른 결과 정렬
    if (sortBy == "오름차순") {
      results.sort((a, b) => a['startTime'].compareTo(b['startTime']));
    } else if (sortBy == "내림차순") {
      results.sort((a, b) => b['startTime'].compareTo(a['startTime']));
    }

    return results;
  }
}
