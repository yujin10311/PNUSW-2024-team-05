package com.example.chat2

data class ContentModel (
    var title: String?,
    var content: String?,
    var hashtag: String?,
    var time: String?){
        constructor() : this("", "", "", "")
}