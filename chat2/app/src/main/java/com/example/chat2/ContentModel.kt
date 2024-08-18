package com.example.chat2

data class ContentModel (
    var uid: String?,
    var title: String?,
    var content: String?,
    var hashtag: String?,
    var time: String?,
    var e1: Int?,
    var e2: Int?,
    var e3: Int?){
        constructor() : this("", "", "", "", "", 0, 0, 0)
}