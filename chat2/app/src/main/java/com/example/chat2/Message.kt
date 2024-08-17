package com.example.chat2

data class Message(
    var message: String?,
    var sendId: String?
) {
    constructor() : this("", "")
}
data class Message_chat(
    var message: String?,
    var sendId: String? ,
    var emotion: String?
) {
    constructor() : this("", "", "")
}