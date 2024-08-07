const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
//새로운 메시지가 오면 알림 생성
exports.sendChatNotification = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate(async (snapshot, context) => {
    const messageData = snapshot.data();

    // 메시지를 보낸 사용자 ID
    const senderId = messageData.senderId;

    // 채팅방 ID
    const chatId = context.params.chatId;

    // 채팅방 정보를 가져옴
    const chatDoc = await admin.firestore().collection("chats")
      .doc(chatId).get();
    const chatData = chatDoc.data();

    // 메시지를 보낸 사용자의 username 가져옴
    const senderDoc = await admin.firestore().collection("user")
      .doc(senderId).get();
    const senderData = senderDoc.data();
    const senderUsername = senderData.username;

    // 채팅방 참여자 리스트
    const participants = chatData.participants;

    // 메시지를 보낸 사용자를 제외한 나머지 사용자들에게 알림을 생성
    for (const participant of participants) {
      if (participant !== senderId) {
        const userDoc = await admin.firestore().collection("user")
          .doc(participant).get();
        const userData = userDoc.data();
        if (userData) {
          // 알림 저장
          await admin.firestore().collection("alarms")
            .doc(participant).collection("userAlarms").add({
              "message": `${senderUsername}님으로부터 메시지가 도착했습니다.`,
              "timestamp": admin.firestore.FieldValue.serverTimestamp(),
              "chatId": chatId,
              "senderId": senderId,
              "read": false, // 새로운 알림은 읽지 않은 상태로 설정
            });

          // 알람 상태 업데이트
          await admin.firestore().collection("alarms").doc(participant).set({
            "hasNewChat": true,
          }, { merge: true });
        }
      }
    }

    console.log("알림 저장 완료");
  });
//새로운 채팅이 왔는지 확인하고 트리거
  exports.updateHasNewChat = functions.firestore
    .document('chats/{chatId}/messages/{messageId}')
    .onCreate(async (snapshot, context) => {
        const messageData = snapshot.data();
        const senderId = messageData.senderId;
        const chatId = context.params.chatId;

        // 채팅방 정보를 가져옴
        const chatDoc = await admin.firestore().collection('chats').doc(chatId).get();
        const chatData = chatDoc.data();
        const participants = chatData.participants;

        const unreadParticipants = participants.filter(participant => {
            return !chatData.lastMessageReadBy.includes(participant) && participant !== senderId;
        });

        if (unreadParticipants.length > 0) {
            const batch = admin.firestore().batch();

            unreadParticipants.forEach(participant => {
                const alarmDocRef = admin.firestore().collection('alarms').doc(participant);
                batch.set(alarmDocRef, { hasNewChat: true }, { merge: true });
            });

            await batch.commit();
            console.log('hasNewChat updated for unread participants');
        } else {
            console.log('All participants have read the message or sender is the only participant');
        }
    });
//모든 채팅방을 확인하여 읽지 않은 메시지가 있는지 확인
    exports.markMessageAsRead = functions.firestore
    .document('chats/{chatId}')
    .onUpdate(async (change, context) => {
        const beforeData = change.before.data();
        const afterData = change.after.data();

        const lastMessageReadByBefore = beforeData.lastMessageReadBy || [];
        const lastMessageReadByAfter = afterData.lastMessageReadBy || [];

        // 메시지를 읽은 사용자를 찾음
        const newReaders = lastMessageReadByAfter.filter(userId => !lastMessageReadByBefore.includes(userId));

        if (newReaders.length > 0) {
            const batch = admin.firestore().batch();

            for (const userId of newReaders) {
                // 모든 채팅방을 확인하여 읽지 않은 메시지가 있는지 확인
                const chatDocs = await admin.firestore().collection('chats')
                    .where('participants', 'array-contains', userId)
                    .get();

                let hasUnreadMessages = false;

                for (const chatDoc of chatDocs.docs) {
                    const chatData = chatDoc.data();
                    if (!chatData.lastMessageReadBy.includes(userId)) {
                        hasUnreadMessages = true;
                        break;
                    }
                }

                // 읽지 않은 메시지가 없다면 hasNewChat을 false로 설정
                if (!hasUnreadMessages) {
                    const alarmDocRef = admin.firestore().collection('alarms').doc(userId);
                    batch.set(alarmDocRef, { hasNewChat: false }, { merge: true });
                }
            }

            await batch.commit();
            console.log('hasNewChat updated for users with no unread messages');
        } else {
            console.log('No new readers found');
        }
    });