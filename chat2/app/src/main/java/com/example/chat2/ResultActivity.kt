package com.example.chat2

import android.content.Intent
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.chat2.databinding.ActivityResultBinding
import com.example.chat2.databinding.ActivitySignUpBinding

class ResultActivity : AppCompatActivity() {

    private lateinit var binding: ActivityResultBinding


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityResultBinding.inflate(layoutInflater)
        enableEdgeToEdge()
        setContentView(binding.root)

        val score = intent.getIntExtra("score",0)
        val totalSize = intent.getIntExtra("totalSize",0)

        //점수 보여주기
        binding.scoreText.text = getString(R.string.count_label, score, totalSize)

        //다시하기 버튼
        binding.resetBtn.setOnClickListener {
            val intent = Intent(this@ResultActivity, HomeActivity::class.java)
            startActivity(intent)
        }
    }
}