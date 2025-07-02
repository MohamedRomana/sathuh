// models/chat_room_model.dart
class ChatRoomModel {
  final String id;
  final String otherUserId; // معرف المستخدم الآخر في المحادثة
  final String otherUserName; // اسم المستخدم الآخر
  final String lastMessage; // آخر رسالة في المحادثة
  final String lastMessageTime; // وقت آخر رسالة

  ChatRoomModel({
    required this.id,
    required this.otherUserId,
    required this.otherUserName,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['_id'],
      otherUserId: json['otherUserId'],
      otherUserName: json['otherUserName'],
      lastMessage: json['lastMessage'] ?? 'No messages yet',
      lastMessageTime: json['lastMessageTime'] ?? '',
    );
  }
}

class ChatMessageModel {
  final String fromId;
  final String message;
  final String? timestamp;

  ChatMessageModel({
    required this.fromId,
    required this.message,
    this.timestamp,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      fromId: json['fromId'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }
}
