package com.example.chat2

data class User(
    var name: String,
    var email: String,
    var uId: String
){
    constructor(): this("","","")
}
