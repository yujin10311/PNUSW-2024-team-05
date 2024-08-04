import 'package:cloud_firestore/cloud_firestore.dart';
import 'shared_preferences_helper.dart';
import 'package:intl/intl.dart';

class FirebaseHelper {
  final Map<String, DateTime> stringToDate = {
    '오전 9시': DateTime(1, 1, 1, 9),
    '오전 10시': DateTime(1, 1, 1, 10),
    '오전 11시': DateTime(1, 1, 1, 11),
    '정오': DateTime(1, 1, 1, 12),
    '오후 1시': DateTime(1, 1, 1, 13),
    '오후 2시': DateTime(1, 1, 1, 14),
    '오후 3시': DateTime(1, 1, 1, 15),
    '오후 4시': DateTime(1, 1, 1, 16),
    '오후 5시': DateTime(1, 1, 1, 17),
    '오후 6시': DateTime(1, 1, 1, 18),
    '오후 7시': DateTime(1, 1, 1, 19),
    '오후 8시': DateTime(1, 1, 1, 20),
    '오후 9시': DateTime(1, 1, 1, 21),
  };

  final Map<DateTime, String> dateToString = {
    DateTime(1, 1, 1, 9): '오전 9시',
    DateTime(1, 1, 1, 10): '오전 10시',
    DateTime(1, 1, 1, 11): '오전 11시',
    DateTime(1, 1, 1, 12): '정오',
    DateTime(1, 1, 1, 13): '오후 1시',
    DateTime(1, 1, 1, 14): '오후 2시',
    DateTime(1, 1, 1, 15): '오후 3시',
    DateTime(1, 1, 1, 16): '오후 4시',
    DateTime(1, 1, 1, 17): '오후 5시',
    DateTime(1, 1, 1, 18): '오후 6시',
    DateTime(1, 1, 1, 19): '오후 7시',
    DateTime(1, 1, 1, 20): '오후 8시',
    DateTime(1, 1, 1, 21): '오후 9시',
  };

  static String dateDifferenceToString(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}일 전';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}달 전';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}년 전';
    }
  }

  // 이메일이 등록되어 있는지 확인
  static Future<bool> checkEmail(String email) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot result = await firestore
          .collection('user')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return result.docs.isEmpty;
    } catch (e) {
      print('Error checking email: $e');
      return false;
    }
  }

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
      'imgUrl': '',
      'imgEmbd': '',
      'phoneNum': prefs['_phoneNum'] ?? '',
      'phoneNum2': prefs['_phoneNum2'] ?? '',
      'city': prefs['_city'] ?? '',
      'gu': prefs['_gu'] ?? '',
      'dong': prefs['_dong'] ?? '',
      'activityType': prefs['_activityType'] ?? '',
      'symptom': prefs['_symptom'] ?? '',
      'withPet': withPet,
      'withCam': withCam,
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
      'age': prefs['_age'] ?? '',
      'gender': prefs['_gender'] ?? '',
      'imgUrl': '',
      'imgEmbd': '',
      'phoneNum': prefs['_phoneNum'] ?? '',
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
      DateTime startTime, DateTime endTime, String dong, String sortBy) async {
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
        .where('status', whereIn: ['posted', 'notMatched']);

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

    // print('Fetched ${results.length} posts:');
    // for (var result in results) {
    //   print('--- Post ---');
    //   result.forEach((key, value) {
    //     print('$key: $value\n');
    //   });
    // }

    if (sortBy == "오름차순") {
      results.sort((a, b) => a['startTime'].compareTo(b['startTime']));
    } else if (sortBy == "내림차순") {
      results.sort((a, b) => b['startTime'].compareTo(a['startTime']));
    }

    return results;
  }

  // 내 공고 쿼리(시니어)
  static Future<List<Map<String, dynamic>>> queryMyPost(String myUid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    Query postsQuery = firestore
        .collection('posts')
        .where('seniorUid', isEqualTo: myUid)
        .where('status', whereIn: ['posted', 'notMatched']); // 조건 추가

    QuerySnapshot postsSnapshot = await postsQuery.get();

    List<Map<String, dynamic>> results = [];

    for (var postDoc in postsSnapshot.docs) {
      var postData = postDoc.data() as Map<String, dynamic>;
      results.add({
        'postId': postDoc.id,
        'status': postData['status'] ??
            '', // posted, notMatched, matched, activated, finished, failed
        'mateUid': postData['mateUid'] ?? '',
        'activityType': postData['activityType'] ?? '',
        'startTime': (postData['startTime'] as Timestamp).toDate(),
        'endTime': (postData['endTime'] as Timestamp).toDate(),
      });
    }

    results.sort((a, b) => a['startTime'].compareTo(b['startTime']));

    return results;
  }

  // 공고 화면: 내 공고 올리기(시니어)
  static Future<bool> postMyPost(Map<String, dynamic> postInfo) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    print('seniorUid: ${postInfo['seniorUid']}');
    print('city: ${postInfo['city']}');
    print('gu: ${postInfo['gu']}');
    print('dong: ${postInfo['dong']}');
    print('activityType: ${postInfo['activityType']}');
    print('startTime: ${postInfo['startTime']}');
    print('endTime: ${postInfo['endTime']}');

    try {
      await firestore.collection('posts').add({
        'seniorUid': postInfo['seniorUid'],
        'city': postInfo['city'],
        'gu': postInfo['gu'],
        'dong': postInfo['dong'],
        'activityType': postInfo['activityType'],
        'startTime': Timestamp.fromDate(postInfo['startTime']),
        'endTime': Timestamp.fromDate(postInfo['endTime']),
        'credit': 5,
        'status': 'posted',
        'startImgUrl': null,
        'startReport': null,
        'endImgUrl': null,
        'endReport': null,
        'ratingByMate': null,
        'reviewByMate': null,
        'ratingBySenior': null,
        'reviewBySenior': null,
      });
      print('Post added successfully');
      return true; // 성공 시 true 반환
    } catch (e) {
      print('Failed to add post: $e');
      return false; // 에러 발생 시 false 반환
    }
  }

  static Future<bool> deleteMyPost(String postId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('posts').doc(postId).delete();
      print("Post with ID: $postId has been successfully deleted.");
      return true; // 성공 시 true 반환
    } catch (e) {
      print("Error deleting post: $e");
      return false; // 에러 발생 시 false 반환
    }
  }

  // 지원 가능 여부 확인 (메이트)
  static Future<String> checkApply(String postId, String myUid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      // 'posts' 컬렉션 내의 doc id가 postId와 일치하는 문서를 찾음
      DocumentSnapshot postSnapshot =
          await firestore.collection('posts').doc(postId).get();

      if (!postSnapshot.exists) {
        // postId에 해당하는 문서가 존재하지 않으면 true를 반환
        return 'postNotExists';
      }

      // 'mates' 서브 컬렉션을 체크
      CollectionReference matesCollection =
          firestore.collection('posts').doc(postId).collection('mates');
      QuerySnapshot matesSnapshot = await matesCollection.get();

      if (matesSnapshot.docs.isEmpty) {
        // 'mates' 서브 컬렉션이 존재하지 않으면 true를 반환
        return 'canApply';
      }

      // 'mates' 서브 컬렉션 내의 모든 문서를 검사
      for (var mateDoc in matesSnapshot.docs) {
        var mateData = mateDoc.data() as Map<String, dynamic>;
        if (mateData['mateUid'] == myUid) {
          // 'mateUid' 필드가 myUid와 동일한 문서가 존재하면 false를 반환
          return 'alreadyApplied';
        }
      }

      // 'mateUid' 필드가 myUid와 동일한 문서가 존재하지 않으면 true를 반환
      return 'canApply';
    } catch (e) {
      print("Error in checkApply: $e");
      return 'error'; // 에러 발생 시 false 반환
    }
  }

  // 지원하기 (메이트)
  static Future<bool> applyMatching(String postId, String myUid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference postRef = firestore.collection('posts').doc(postId);

    try {
      DocumentSnapshot postSnapshot = await postRef.get();

      if (!postSnapshot.exists) {
        print('공고가 존재하지 않습니다.');
        return false;
      }

      var postData = postSnapshot.data() as Map<String, dynamic>;
      String status = postData['status'];
      print("-------applyInfo--------");
      print("postId: ${postId}");
      print("myUid: ${myUid}");
      print("status: ${status}");

      if (status == 'posted') {
        await postRef.update({'status': 'notMatched'});

        CollectionReference matesRef = postRef.collection('mates');
        await matesRef.add({
          'mateUid': myUid,
          'applyTime': Timestamp.now(),
        });
        print("신청이 완료되었습니다.");
        return true;
      } else if (status == 'notMatched') {
        CollectionReference matesRef = postRef.collection('mates');
        await matesRef.add({
          'mateUid': myUid,
          'applyTime': Timestamp.now(),
        });
        print("신청이 완료되었습니다.");
        return true;
      } else {
        print("신청할 수 없습니다.");
        return false;
      }
    } catch (e) {
      print('Error applying for matching: $e');
      return false;
    }
  }

  // 지원 취소 (메이트)
  static Future<bool> cancelApply(String postId, String myUid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      // 'posts' 컬렉션 내의 doc id가 postId와 일치하는 문서를 찾음
      DocumentSnapshot postSnapshot =
          await firestore.collection('posts').doc(postId).get();

      if (!postSnapshot.exists) {
        // postId에 해당하는 문서가 존재하지 않으면 false 반환
        return false;
      }

      // 'mates' 서브 컬렉션 내의 mateUid가 myUid와 동일한 문서를 찾음
      QuerySnapshot matesSnapshot = await firestore
          .collection('posts')
          .doc(postId)
          .collection('mates')
          .where('mateUid', isEqualTo: myUid)
          .get();

      if (matesSnapshot.docs.isEmpty) {
        // mateUid가 myUid와 동일한 문서가 존재하지 않으면 false 반환
        return false;
      }

      // mateUid가 myUid와 동일한 문서를 삭제
      for (var mateDoc in matesSnapshot.docs) {
        await mateDoc.reference.delete();
      }

      // 'mates' 서브 컬렉션 내의 문서가 남아있는지 확인
      QuerySnapshot remainingMatesSnapshot = await firestore
          .collection('posts')
          .doc(postId)
          .collection('mates')
          .get();

      if (remainingMatesSnapshot.docs.isEmpty) {
        // mates 서브 컬렉션 내의 문서가 남아있지 않으면 'status' 필드를 'posted'로 변경
        await firestore
            .collection('posts')
            .doc(postId)
            .update({'status': 'posted'});
      }

      print("삭제에 성공했습니다. [postId: $postId / myUid: $myUid]");
      return true; // 성공 시 true 반환
    } catch (e) {
      print("Error in cancelApply: $e");
      return false; // 에러 발생 시 false 반환
    }
  }

  // 매칭화면의 '매칭 전' 텝 정보 쿼리 (메이트)
  static Future<List<Map<String, dynamic>>> queryNotMatchedByMate(
      String myUid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 1. status가 'notMatched'인 posts를 검색
    QuerySnapshot postsSnapshot = await firestore
        .collection('posts')
        .where('status', isEqualTo: 'notMatched')
        .get();

    List<Map<String, dynamic>> results = [];

    // Step 2: posts 순회
    for (var postDoc in postsSnapshot.docs) {
      var postData = postDoc.data() as Map<String, dynamic>;
      String postId = postDoc.id;

      // Step 3: Check mates sub-collection
      QuerySnapshot matesSnapshot = await firestore
          .collection('posts')
          .doc(postId)
          .collection('mates')
          .where('mateUid', isEqualTo: myUid)
          .get();

      // If there are matching mates documents
      if (matesSnapshot.docs.isNotEmpty) {
        var mateData = matesSnapshot.docs.first.data() as Map<String, dynamic>;

        // Get senior data
        DocumentSnapshot seniorSnapshot =
            await firestore.collection('user').doc(postData['seniorUid']).get();

        if (seniorSnapshot.exists) {
          var seniorData = seniorSnapshot.data() as Map<String, dynamic>;

          // Compile the result
          results.add({
            'imgUrl': seniorData['imgUrl'] ?? '',
            'username': seniorData['username'] ?? '',
            'rating': seniorData['rating'] ?? 0.0,
            'ratingCount': seniorData['ratingCount'] ?? 0,
            'dependentType': seniorData['dependentType'] ?? '',
            'withPet': seniorData['withPet'] ?? false,
            'withCam': seniorData['withCam'] ?? false,
            'petInfo': seniorData['petInfo'] ?? '',
            'symptom': List<String>.from(seniorData['symptom'] ?? []),
            'symptomInfo': seniorData['symptomInfo'] ?? '',
            'walkingType': seniorData['walkingType'] ?? '',
            'addInfo': seniorData['addInfo'] ?? '',
            'uid': postData['seniorUid'] ?? '',
            'postId': postId,
            'city': postData['city'] ?? '',
            'gu': postData['gu'] ?? '',
            'dong': postData['dong'] ?? '',
            'date':
                '${DateFormat('yy.M.d').format((postData['startTime'] as Timestamp).toDate())}' ??
                    '',
            'startTime': (postData['startTime'] as Timestamp).toDate(),
            'endTime': (postData['endTime'] as Timestamp).toDate(),
            'activityType': postData['activityType'] ?? '',
            'applyTime': (mateData['applyTime'] as Timestamp).toDate(),
            'applyTimeText': dateDifferenceToString(
                (mateData['applyTime'] as Timestamp).toDate()),
          });
        }
      }
    }
    results.sort((a, b) => a['startTime'].compareTo(b['startTime']));

    return results;
  }

  // 매칭화면의 '매칭 전' 텝 정보 쿼리 (시니어)
  static Future<List<Map<String, dynamic>>> queryNotMatchedBySenior(
      String myUid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> results = [];

    try {
      // 'posts' 컬렉션에서 'seniorUid'가 myUid와 같고 'status'가 'notMatched'인 문서를 가져옴
      QuerySnapshot postsSnapshot = await firestore
          .collection('posts')
          .where('seniorUid', isEqualTo: myUid)
          .where('status', isEqualTo: 'notMatched')
          .get();

      for (var postDoc in postsSnapshot.docs) {
        var postData = postDoc.data() as Map<String, dynamic>;

        // 'mates' 서브 컬렉션을 순회
        QuerySnapshot matesSnapshot = await firestore
            .collection('posts')
            .doc(postDoc.id)
            .collection('mates')
            .get();

        for (var mateDoc in matesSnapshot.docs) {
          var mateData = mateDoc.data() as Map<String, dynamic>;
          String mateUid = mateData['mateUid'];

          // 'user' 컬렉션에서 mateUid와 같은 문서를 가져옴
          DocumentSnapshot userSnapshot =
              await firestore.collection('user').doc(mateUid).get();

          if (userSnapshot.exists) {
            var userData = userSnapshot.data() as Map<String, dynamic>;

            results.add({
              'uid': mateUid ?? '',
              'username': userData['username'] ?? '',
              'imgUrl': userData['imgUrl'] ?? '',
              'rating': userData['rating'] ?? 0.0,
              'ratingCount': userData['ratingCount'] ?? 0,
              'city': userData['city'] ?? '',
              'gu': userData['gu'] ?? '',
              'dong': userData['dong'] ?? '',
              'age': userData['age'] ?? '',
              'gender': userData['gender'] ?? '',
              'mateActivityType': userData['activityType'] ?? '',
              'dayTime': userData['dayTime'] ?? '',
              'addInfo': userData['addInfo'] ?? '',
              'residentCert': userData['residentCert'] ?? false,
              'schoolCert': userData['schoolCert'] ?? false,
              'applyTime': (mateData['applyTime'] as Timestamp).toDate(),
              'applyTimeText': dateDifferenceToString(
                  (mateData['applyTime'] as Timestamp).toDate()),
              'postId': postDoc.id,
              'date':
                  '${DateFormat('yy.M.d').format((postData['startTime'] as Timestamp).toDate())}',
              'startTime': (postData['startTime'] as Timestamp).toDate(),
              'endTime': (postData['endTime'] as Timestamp).toDate(),
              'activityType': postData['activityType'] ?? '',
            });
          }
        }
      }
    } catch (e) {
      print("Error in queryNotMatchedBySenior: $e");
    }

    results.sort((a, b) => b['applyTime'].compareTo(a['applyTime']));

    return results;
  }

  // 매칭화면의 '매칭 후' 텝 정보 쿼리 (메이트)
  static Future<List<Map<String, dynamic>>> queryMatchedByMate(
      String myUid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 1. status가 'notMatched'인 posts를 검색
    QuerySnapshot postsSnapshot =
        await firestore.collection('posts').where('status', whereIn: [
      'matched',
      'activated',
      'finished',
      'failed',
    ]).get();

    List<Map<String, dynamic>> results = [];

    // Step 2: posts 순회
    for (var postDoc in postsSnapshot.docs) {
      var postData = postDoc.data() as Map<String, dynamic>;
      String postId = postDoc.id;

      // Step 3: Check mates sub-collection
      QuerySnapshot matesSnapshot = await firestore
          .collection('posts')
          .doc(postId)
          .collection('mates')
          .where('mateUid', isEqualTo: myUid)
          .get();

      // If there are matching mates documents
      if (matesSnapshot.docs.isNotEmpty) {
        var mateData = matesSnapshot.docs.first.data() as Map<String, dynamic>;

        // Get senior data
        DocumentSnapshot seniorSnapshot =
            await firestore.collection('user').doc(postData['seniorUid']).get();

        if (seniorSnapshot.exists) {
          var seniorData = seniorSnapshot.data() as Map<String, dynamic>;

          // Compile the result
          results.add({
            'imgUrl': seniorData['imgUrl'] ?? '',
            'username': seniorData['username'] ?? '',
            'rating': seniorData['rating'] ?? 0.0,
            'ratingCount': seniorData['ratingCount'] ?? 0,
            'dependentType': seniorData['dependentType'] ?? '',
            'withPet': seniorData['withPet'] ?? false,
            'withCam': seniorData['withCam'] ?? false,
            'petInfo': seniorData['petInfo'] ?? '',
            'symptom': List<String>.from(seniorData['symptom'] ?? []),
            'symptomInfo': seniorData['symptomInfo'] ?? '',
            'walkingType': seniorData['walkingType'] ?? '',
            'addInfo': seniorData['addInfo'] ?? '',
            'uid': postData['seniorUid'] ?? '',
            'postId': postId,
            'city': postData['city'] ?? '',
            'gu': postData['gu'] ?? '',
            'dong': postData['dong'] ?? '',
            'date':
                '${DateFormat('yy.M.d').format((postData['startTime'] as Timestamp).toDate())}' ??
                    '',
            'startTime': (postData['startTime'] as Timestamp).toDate(),
            'endTime': (postData['endTime'] as Timestamp).toDate(),
            'activityType': postData['activityType'] ?? '',
            'applyTime': (mateData['applyTime'] as Timestamp).toDate(),
            'applyTimeText': dateDifferenceToString(
                (mateData['applyTime'] as Timestamp).toDate()),
            'status': postData['status'],
          });
        }
      }
    }
    results.sort((a, b) => a['startTime'].compareTo(b['startTime']));

    return results;
  }

  // 매칭화면의 '매칭 후' 텝 정보 쿼리 (시니어)
  static Future<List<Map<String, dynamic>>> queryMatchedBySenior(
      String myUid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> results = [];

    try {
      // 'posts' 컬렉션에서 'seniorUid'가 myUid와 같고 'status'가 'notMatched'인 문서를 가져옴
      QuerySnapshot postsSnapshot = await firestore
          .collection('posts')
          .where('seniorUid', isEqualTo: myUid)
          .where('status', whereIn: [
        'matched',
        'activated',
        'finished',
        'failed',
      ]).get();

      for (var postDoc in postsSnapshot.docs) {
        var postData = postDoc.data() as Map<String, dynamic>;

        // 'mates' 서브 컬렉션을 순회
        QuerySnapshot matesSnapshot = await firestore
            .collection('posts')
            .doc(postDoc.id)
            .collection('mates')
            .get();

        for (var mateDoc in matesSnapshot.docs) {
          var mateData = mateDoc.data() as Map<String, dynamic>;
          String mateUid = mateData['mateUid'];

          // 'user' 컬렉션에서 mateUid와 같은 문서를 가져옴
          DocumentSnapshot userSnapshot =
              await firestore.collection('user').doc(mateUid).get();

          if (userSnapshot.exists) {
            var userData = userSnapshot.data() as Map<String, dynamic>;

            results.add({
              'uid': mateUid ?? '',
              'username': userData['username'] ?? '',
              'imgUrl': userData['imgUrl'] ?? '',
              'rating': userData['rating'] ?? 0.0,
              'ratingCount': userData['ratingCount'] ?? 0,
              'city': userData['city'] ?? '',
              'gu': userData['gu'] ?? '',
              'dong': userData['dong'] ?? '',
              'age': userData['age'] ?? '',
              'gender': userData['gender'] ?? '',
              'mateActivityType': userData['activityType'] ?? '',
              'dayTime': userData['dayTime'] ?? '',
              'addInfo': userData['addInfo'] ?? '',
              'residentCert': userData['residentCert'] ?? false,
              'schoolCert': userData['schoolCert'] ?? false,
              'applyTime': (mateData['applyTime'] as Timestamp).toDate(),
              'applyTimeText': dateDifferenceToString(
                  (mateData['applyTime'] as Timestamp).toDate()),
              'postId': postDoc.id,
              'date':
                  '${DateFormat('yy.M.d').format((postData['startTime'] as Timestamp).toDate())}',
              'startTime': (postData['startTime'] as Timestamp).toDate(),
              'endTime': (postData['endTime'] as Timestamp).toDate(),
              'activityType': postData['activityType'] ?? '',
            });
          }
        }
      }
    } catch (e) {
      print("Error in queryNotMatchedBySenior: $e");
    }

    results.sort((a, b) => b['applyTime'].compareTo(a['applyTime']));

    return results;
  }
}
