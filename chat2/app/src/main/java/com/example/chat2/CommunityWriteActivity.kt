package com.example.chat2

import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.chat2.databinding.ActivityWritecommunityBinding
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale

class CommunityWriteActivity : AppCompatActivity() {
    // 바인딩 객체
    private lateinit var binding: ActivityWritecommunityBinding

    lateinit var mAuth: FirebaseAuth // 인증 객체
    lateinit var mDbRef: DatabaseReference // DB 객체

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityWritecommunityBinding.inflate(layoutInflater)

        enableEdgeToEdge()
        setContentView(binding.root)
        mAuth = FirebaseAuth.getInstance()
        mDbRef = FirebaseDatabase.getInstance().reference

        // 메세지 전송 버튼 이벤트
        binding.submitbutton.setOnClickListener {
            val senderUid = mAuth.currentUser?.uid
            val title = binding.headtext.text.toString()
            val content = binding.bodytext.text.toString()
            val hashtag = binding.HashTag.text.toString()
            val time = getTime()

            // push()는 목록을 만들어주며 랜덤한 문자열을 할당한다.
            mDbRef.child("community").child(senderUid.toString()).push().setValue(ContentModel(title, content, hashtag,time))

            // child()는 해당 키 위치로 이동하는 메서드로 child()를 사용하여 key 값의 하위에 값을 저장한다.
            // setValue() 메서드를 사용하여 값을 저장한다.

            Toast.makeText(this, "게시글 입력 완료", Toast.LENGTH_SHORT).show()

            finish()
        }
    }

    // 시간을 구하는 함수
    fun getTime(): String {
        val currentDateTime = Calendar.getInstance().time
        val dateFormat =
            SimpleDateFormat("yyyy.MM.dd HH:mm:ss", Locale.KOREA).format(currentDateTime)

        return dateFormat
    }
}