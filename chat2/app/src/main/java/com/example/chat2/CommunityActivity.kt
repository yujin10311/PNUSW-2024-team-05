package com.example.chat2

import android.annotation.SuppressLint
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import com.example.chat2.databinding.ActivityCommunityBinding
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import kotlin.reflect.typeOf


class CommunityActivity: AppCompatActivity() {
    @SuppressLint("MissingInflatedId")
    private lateinit var database: DatabaseReference
    private lateinit var binding: ActivityCommunityBinding
    lateinit var cid: String
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityCommunityBinding.inflate(layoutInflater)
        setContentView(binding.root)
        database = FirebaseDatabase.getInstance().reference
        database.child("community").get().addOnSuccessListener {
            Log.i("firebase", "Got value ${it.value}")
            val curcontents = it.children.toList()[(0..<it.childrenCount.toInt()).random()]
            cid = curcontents.key.toString()
            binding.textTitle.text = curcontents.child("title").value.toString()
            binding.textContent.text = curcontents.child("content").value.toString()
            binding.textHashtag.text = curcontents.child("hashtag").value.toString()
            binding.textE1.text = curcontents.child("e1").value.toString()
            binding.textE2.text = curcontents.child("e2").value.toString()
            binding.textE3.text = curcontents.child("e3").value.toString()
        }.addOnFailureListener{
            Log.e("firebase", "Error getting data", it)
        }
        binding.refreshButton.setOnClickListener{
            database.child("community").get().addOnSuccessListener {
                Log.i("firebase", "Got value ${it.value}")
                val curcontents = it.children.toList()[(0..<it.childrenCount.toInt()).random()]
                cid = curcontents.key.toString()
                binding.textTitle.text = curcontents.child("title").value.toString()
                binding.textContent.text = curcontents.child("content").value.toString()
                binding.textHashtag.text = curcontents.child("hashtag").value.toString()
                binding.textE1.text = curcontents.child("e1").value.toString()
                binding.textE2.text = curcontents.child("e2").value.toString()
                binding.textE3.text = curcontents.child("e3").value.toString()
            }.addOnFailureListener{
                Log.e("firebase", "Error getting data", it)
            }
        }
        binding.e1button.setOnClickListener {
            database.child("community").child(cid).child("e1").get().addOnSuccessListener {
                val tmp = it.value.toString().toInt() + 1
                database.child("community").child(cid).child("e1").setValue(tmp)
                binding.textE1.text = tmp.toString()
            }
        }
        binding.e2button.setOnClickListener {
            database.child("community").child(cid).child("e2").get().addOnSuccessListener {
                val tmp = it.value.toString().toInt() + 1
                database.child("community").child(cid).child("e2").setValue(tmp)
                binding.textE2.text = tmp.toString()
            }
        }
        binding.e3button.setOnClickListener {
            database.child("community").child(cid).child("e3").get().addOnSuccessListener {
                val tmp = it.value.toString().toInt() + 1
                database.child("community").child(cid).child("e3").setValue(tmp)
                binding.textE3.text = tmp.toString()
            }
        }
        binding.writebutton.setOnClickListener {
            val intent = Intent(this, CommunityWriteActivity::class.java)
            this.startActivity(intent)
        }
    }
}

private operator fun Any?.plus(i: Int) {

}
