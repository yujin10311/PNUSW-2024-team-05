
package com.example.chat2

import android.annotation.SuppressLint
import android.content.Intent
import android.os.Bundle
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class HomeActivity : AppCompatActivity() {
    @SuppressLint("MissingInflatedId")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_home)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        findViewById<TextView>(R.id.chat_btn).setOnClickListener {
            val intent = Intent(this, ChatActivity::class.java)

            this.startActivity(intent)
        }

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

    }


}