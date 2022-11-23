class Dialog {
  int chatQuestionsId;
  String chatQuestionsText;
  int chatQuestionsStatus;
  String createdAt;
  String updatedAt;

  Dialog(
      {this.chatQuestionsId,
      this.chatQuestionsText,
      this.chatQuestionsStatus,
      this.createdAt,
      this.updatedAt});

  Dialog.fromJson(Map<String, dynamic> json) {
    chatQuestionsId = json['chat_questions_id'];
    chatQuestionsText = json['chat_questions_text'];
    chatQuestionsStatus = json['chat_questions_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_questions_id'] = this.chatQuestionsId;
    data['chat_questions_text'] = this.chatQuestionsText;
    data['chat_questions_status'] = this.chatQuestionsStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
