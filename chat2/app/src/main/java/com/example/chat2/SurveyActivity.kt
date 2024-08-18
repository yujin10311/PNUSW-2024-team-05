package com.example.chat2

import android.content.Intent
import android.graphics.Color
import android.graphics.Typeface
import android.os.Build
import android.os.Bundle
import android.view.View
import android.widget.TextView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.chat2.databinding.ActivitySurveyBinding
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import java.time.LocalDate

class SurveyActivity : AppCompatActivity(), View.OnClickListener {

    private lateinit var binding: ActivitySurveyBinding

    lateinit var mAuth: FirebaseAuth // 인증 객체
    lateinit var mDbRef: DatabaseReference // DB 객체

    private var currentPosition: Int = 1 //질문 위치
    private var selectedOption: Int = 0 //선택 답변 값
    private var score: Int = 0 // 점수

    private lateinit var questionList: ArrayList<Question>

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySurveyBinding.inflate(layoutInflater)
        enableEdgeToEdge()
        setContentView(binding.root)

        // 초기화
        mAuth = FirebaseAuth.getInstance()
        mDbRef = FirebaseDatabase.getInstance().reference

        val senderUid = mAuth.currentUser?.uid



        //질문 리스트 가져오기
        questionList = QuestionData.getQuestion()

        //화면 세팅
        getQuestionData()

        binding.option1Text.setOnClickListener(this)
        binding.option2Text.setOnClickListener(this)
        binding.option3Text.setOnClickListener(this)
        binding.option4Text.setOnClickListener(this)

        //답변 체크 이벤트
        binding.submitBtn.setOnClickListener{

            if(selectedOption != 0) {

                val question = questionList[currentPosition - 1]

                //정답 체크(선택 답변과 정답을 비교)

                if(selectedOption == 2){
                    score++
                }

                if(selectedOption == 3){
                    score+=2
                }

                if(selectedOption == 4){
                    score+=3
                }

                if(currentPosition == questionList.size) {
                    binding.submitBtn.text = getString(R.string.submit, "끝")
                }else{
                    binding.submitBtn.text = getString(R.string.submit, "다음")
                }

            } else {
                //위치 값 상승
                currentPosition++
                when{
                    currentPosition <= questionList.size -> {
                        //다음 문제 세팅
                        getQuestionData()

                    }

                    else ->{
                        //결과 액티비티로 넘어가는 코드
                        Toast.makeText(this, "설문이 끝났습니다.",Toast.LENGTH_SHORT).show()
                        val localDate: LocalDate = LocalDate.now()
                        mDbRef.child("survey").child(senderUid.toString()).child(localDate.toString()).push()
                            .setValue(Score(score))
                        val intent = Intent(this@SurveyActivity, ResultActivity::class.java)
                        intent.putExtra("score", score)
                        intent.putExtra("totalSize", 27)
                        startActivity(intent)
                        finish()

                    }
                }

            }

            //선택값 초기화
            selectedOption = 0
        } //submitBtn



//        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
//            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
//            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
//            insets
//        }
    }

    private fun getQuestionData(){

        //답변 설정 초기화
        setOptionStyle()

        //질문 변수에 담기
        val question = questionList[currentPosition-1]

        //상태바 위치
        binding.progressBar.progress = currentPosition

        //상태바 최댓값
        binding.progressBar.max = questionList.size

        //현재 위치 표시
        binding.progressText.text = getString(R.string.count_label, currentPosition, questionList.size)

        //질문 표시
        binding.questionText.text = question.question

        //답변 표시
        binding.option1Text.text = question.option_one
        binding.option2Text.text = question.option_two
        binding.option3Text.text = question.option_three
        binding.option4Text.text = question.option_four

        setSubmitBtn("제출")
    }

    //제출 버튼 텍스트 설정
    private fun setSubmitBtn(name: String){

        binding.submitBtn.text = getString(R.string.submit, name)
    }

    /**
     * 답변 스타일 설정
     */
    private fun setOptionStyle(){

        var optionList: ArrayList<TextView> = arrayListOf()
        optionList.add(binding.option1Text)
        optionList.add(binding.option2Text)
        optionList.add(binding.option3Text)
        optionList.add(binding.option4Text)

        //답변 텍스트뷰 설정
        for(op in optionList){
            op.setTextColor(Color.parseColor("#555151"))
            op.background = ContextCompat.getDrawable(this,R.drawable.option_background)
            op.typeface = Typeface.DEFAULT
        }
    }

    /**
     * 답변 선택 이벤트
     */
    private fun selectedOptionStyle(view: TextView, opt: Int){

        //옵션 초기화
        setOptionStyle()

        //위치 담기
        selectedOption = opt
        view.setTextColor((Color.parseColor("#5F00FF")))
        view.background = ContextCompat.getDrawable(this,R.drawable.selected_option_background)
        view.typeface = Typeface.DEFAULT_BOLD
    }

    override fun onClick(view: View) {
        when(view.id){
            R.id.option1_text -> selectedOptionStyle(binding.option1Text, 1)
            R.id.option2_text -> selectedOptionStyle(binding.option2Text, 2)
            R.id.option3_text -> selectedOptionStyle(binding.option3Text, 3)
            R.id.option4_text -> selectedOptionStyle(binding.option4Text, 4)
        }
    }
}