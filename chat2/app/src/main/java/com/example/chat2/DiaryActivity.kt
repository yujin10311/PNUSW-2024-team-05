package com.example.chat2

import android.content.Intent
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import com.example.chat2.databinding.ActivityDiaryBinding
import com.google.ai.client.generativeai.GenerativeModel
import com.google.ai.client.generativeai.type.Content
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch


class DiaryActivity: AppCompatActivity() {
    private lateinit var binding: ActivityDiaryBinding
    private lateinit var receiverName: String
    private lateinit var receiverUid: String
    lateinit var mAuth: FirebaseAuth // 인증 객체
    lateinit var mDbRef: DatabaseReference // DB 객체
    private lateinit var receiverRoom: String // 받는 대화방
    private lateinit var senderRoom: String // 보낸 대화방
    private val model = GenerativeModel(
        "gemini-1.5-flash",
        apiKey = "AIzaSyAFUNgEWOFYm4FNk-GkBssKdrsKpCcf5Tw",
    )
    private val chatHistory = mutableListOf<Content>()
    private val chat = model.startChat(chatHistory)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityDiaryBinding.inflate(layoutInflater)
        enableEdgeToEdge()
        setContentView(binding.root)


        val ydm = intent.getStringExtra("YMD").toString()
        receiverName = "gemini"//intent.getStringExtra("name").toString()
        receiverUid = "gemini"//intent.getStringExtra("uId").toString()

        mAuth = FirebaseAuth.getInstance()
        mDbRef = FirebaseDatabase.getInstance().reference

        // 접속자 Uid
        val senderUid = mAuth.currentUser?.uid

        // 보낸이방
        senderRoom = receiverUid + senderUid
        // 받는이방
        receiverRoom = senderUid + receiverUid
        mDbRef.child("chats").child(senderRoom).child(ydm).child("message").addValueEventListener(object : ValueEventListener {
            override fun onDataChange(snapshot: DataSnapshot) {
                var index = 0
                var msg = ""
                for (postSnapshot in snapshot.children) {
                    if (index % 2 == 0){
                        msg = msg + postSnapshot.getValue(Message::class.java)?.message.toString()
                    }
                    index = index + 1
                }
                CoroutineScope(Dispatchers.Main).launch() {
                        var diary = chat.sendMessage("다음 텍스트는 심리상담 챗봇과 상담한 사용자의 채팅 내용이야. 이것을 일기 형식(제목, 내용)으로 바꾸는데 직접 형식을 언급하지 마. 그리고 챗봇에 대한 내용은 빼줘. 텍스트:$msg")

                    binding.diaryText.text = diary.text.toString()
                }

            }
            override fun onCancelled(error: DatabaseError) {
            }
        })
    }
}