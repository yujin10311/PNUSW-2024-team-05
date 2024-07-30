package com.example.chat2

import android.os.Bundle
import android.util.Log
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.chat2.databinding.ActivityChatBinding
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener
import com.google.ai.client.generativeai.GenerativeModel
import com.google.ai.client.generativeai.type.Content
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
// 너무 어렵고
class ChatActivity : AppCompatActivity() {

    private lateinit var receiverName: String
    private lateinit var receiverUid: String

    // 바인딩 객체
    private lateinit var binding: ActivityChatBinding

    lateinit var mAuth: FirebaseAuth // 인증 객체
    lateinit var mDbRef: DatabaseReference // DB 객체

    private lateinit var receiverRoom: String // 받는 대화방
    private lateinit var senderRoom: String // 보낸 대화방

    private lateinit var messageList: ArrayList<Message>

    private val model = GenerativeModel(
        "gemini-1.5-flash",
        apiKey = "AIzaSyAFUNgEWOFYm4FNk-GkBssKdrsKpCcf5Tw",
    )
    private val chatHistory = mutableListOf<Content>()
    private val chat = model.startChat(chatHistory)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityChatBinding.inflate(layoutInflater)

        enableEdgeToEdge()
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        // 초기화
        messageList = ArrayList()
        val messageAdapter: MessageAdapter = MessageAdapter(this, messageList)

        // RecyclerView
        binding.chatRecyclerView.layoutManager = LinearLayoutManager(this)
        binding.chatRecyclerView.adapter = messageAdapter

        // 넘어온 데이터 변수에 담기
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


        // 액션바에 상대방 이름 보여주기기기기
//        supportActionBar?.title = receiverName

        // 메세지 전송 버튼 이벤트
        binding.sendBtn.setOnClickListener {

            val message = binding.messageEdit.text.toString()
            val messageObject = Message(message, senderUid)

            // 데이터 저장
            CoroutineScope(Dispatchers.Main).launch() {
                var response = chat.sendMessage("다음 텍스트에 대해 3줄 이내로 채팅하듯이 심리상담을 해줘 텍스트:$message")
                mDbRef.child("chats").child(senderRoom).child("message").push()
                    .setValue(messageObject)//.addOnSuccessListener {
                // 저장 성공하면(상대방 화면에 -> 이거는 굳이 필요 없을듯)
//                        mDbRef.child("chats").child(receiverRoom).child("message").push()
//                            .setValue(Message(response.text, receiverUid))
//                    }
                // 입력값 초기화
                mDbRef.child("chats").child(senderRoom).child("message").push()
                    .setValue(Message(response.text.toString(), senderUid+"a"))
                binding.messageEdit.setText("")
            }
        }

        // 메시지 가져오기
        mDbRef.child("chats").child(senderRoom).child("message")
            .addValueEventListener(object : ValueEventListener {
                override fun onDataChange(snapshot: DataSnapshot) {
                    messageList.clear()

                    for (postSnapshat in snapshot.children) {
                        val message = postSnapshat.getValue(Message::class.java)
                        messageList.add(message!!)
                    }
                    //적용
                    messageAdapter.notifyDataSetChanged()
                }

                override fun onCancelled(error: DatabaseError) {

                }
            })
    }
}
