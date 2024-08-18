
package com.example.chat2

// import kotlinx.android.synthetic.main.activity_main.*
// import org.jetbrains.anko.toast

import android.annotation.SuppressLint
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.CalendarView
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener
import java.time.LocalDate
import java.time.format.DateTimeFormatter


class HomeActivity : AppCompatActivity() {

    @RequiresApi(Build.VERSION_CODES.O)
    fun formatDate(inputDate: String): String {
        // 입력 문자열 형식 정의
        val inputFormatter = DateTimeFormatter.ofPattern("yyyy-M-d")

        // 입력 문자열을 LocalDate로 파싱
        val date = LocalDate.parse(inputDate, inputFormatter)

        // 원하는 출력 형식으로 포맷팅
        val outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")
        return date.format(outputFormatter)
    }

    @SuppressLint("MissingInflatedId")

    private lateinit var calendarView: CalendarView
    private lateinit var YDMTextView: TextView
    private lateinit var emotionTextView: TextView
    private lateinit var surveyscoreTextView: TextView


    @RequiresApi(Build.VERSION_CODES.O)
    @SuppressLint("DefaultLocale")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_home)
        findViewById<TextView>(R.id.comunity_btn).setOnClickListener {
            val intent = Intent(this, CommunityActivity::class.java)

            this.startActivity(intent)

        }
        findViewById<TextView>(R.id.chat_btn).setOnClickListener {
            val intent = Intent(this, ChatActivity::class.java)

            this.startActivity(intent)

        }
        findViewById<TextView>(R.id.character_btn).setOnClickListener {
            val intent = Intent(this, AvatarActivity::class.java)

            this.startActivity(intent)

        }
        findViewById<TextView>(R.id.check_btn).setOnClickListener {
            val intent = Intent(this, SurveyActivity::class.java)

            this.startActivity(intent)

        }
        calendarView = findViewById(R.id.calendarView)
        YDMTextView = findViewById(R.id.YMD_TextView)
        emotionTextView = findViewById(R.id.emotion_TextView)
        surveyscoreTextView = findViewById(R.id.surveyscore_TextView)

        calendarView.setOnDateChangeListener { view, year, month, dayOfMonth ->
// 달력 날짜가 선택되면
            YDMTextView.visibility = View.VISIBLE // 해당 날짜
            emotionTextView.visibility = View.VISIBLE // emotion
            surveyscoreTextView.visibility = View.VISIBLE // survey_score

            YDMTextView.text = String.format(
                "%d / %d / %d",
                year,
                month + 1,
                dayOfMonth
            )  // 날짜를 보여주는 텍스트에 해당 날짜를 넣는다.


            lateinit var mAuth: FirebaseAuth // 인증 객체
            lateinit var mDbRef: DatabaseReference // DB 객체

            mAuth = FirebaseAuth.getInstance()
            mDbRef = FirebaseDatabase.getInstance().reference

            // 접속자 Uid
            val senderUid = mAuth.currentUser?.uid
            val senderRoom = "gemini"+senderUid


            // Firebase에서 선택한 날짜의 score 값을 가져오기
            if (senderUid != null) {
                mDbRef.child("survey").child(senderUid).child(formatDate(String.format("%d-%d-%d",year,month + 1,dayOfMonth))).orderByKey().limitToFirst(1).addListenerForSingleValueEvent(object : ValueEventListener {
                    override fun onDataChange(snapshot: DataSnapshot) {
                        // 첫 번째 자식 노드 가져오기
                        if (snapshot.exists()) {
                            val firstChildSnapshot = snapshot.children.iterator().next()
                            val pushKey = firstChildSnapshot.key
                            Log.d("FirebaseData", "First pushKey: $pushKey")
                            val scoreSnapshot = firstChildSnapshot.child("score")
                            val score = scoreSnapshot.getValue(Int::class.java)

                            if (score != null) {
                                // score 값을 surveyscoreTextView에 표시
                                surveyscoreTextView.text = "설문 조사 점수 : " + score.toString()
                            } else {
                                // score가 없을 때 기본 값 설정 (예: "No score available")
                                surveyscoreTextView.text = "No score available"
                            }
                        } else {
                            surveyscoreTextView.text = "No score available"
                            Log.d("FirebaseData", "No data found for the given date")
                        }
                    }

                        override fun onCancelled(error: DatabaseError) {
                            // 에러 처리
                            Log.w("FirebaseData", "loadData:onCancelled", error.toException())
                        }
                    })


            }


            emotionTextView.text = "No Chat"
            // Firebase에서 선택한 날짜의 감정분석결과 값을 가져오기
            if (senderUid != null) {
                mDbRef.child("chats").child(senderRoom).child(formatDate(String.format("%d-%d-%d",year,month + 1,dayOfMonth))).child("message").orderByKey().limitToFirst(2).addListenerForSingleValueEvent(object : ValueEventListener {
                    override fun onDataChange(snapshot: DataSnapshot) {
                        // 첫 번째 자식 노드 가져오기
                        if (snapshot.exists()) {

                            val children = snapshot.children.toList()
                            Log.d("Firebasedata", children.toString())

                            if (children.size > 1) {
                                val secondchildsnapshot = children[1]

                                val emotionSnapshot = secondchildsnapshot.child("emotion")
                                val emotion = emotionSnapshot.getValue(String::class.java)

                                if (emotion != null) {
                                    // emotion 값을 emotionTextView에 표시
                                    emotionTextView.text = "감정 분석 결과 : " + emotion.toString()
                                } else {
                                    // emotion이 없을 때 기본 값 설정 (예: "No Chat")
                                    emotionTextView.text = "No Chat"
                                }
                            } else {
                                emotionTextView.text = "No Chat"
                                Log.d("FirebaseData", "No data found for the given date")
                            }
                            }

                    }

                    override fun onCancelled(error: DatabaseError) {
                        // 에러 처리
                        Log.w("FirebaseData", "loadData:onCancelled", error.toException())
                    }
                })


            }


            ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
                val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
                v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
                insets
            }
        }
    }


}