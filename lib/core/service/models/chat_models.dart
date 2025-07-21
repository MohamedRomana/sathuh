class ChatMessageModel {
  final String fromId;
  final String message;
  final String createdAt;
  final bool isPending;

  ChatMessageModel({
    required this.fromId,
    required this.message,
    required this.createdAt,
    required this.isPending,
  });

  ChatMessageModel copyWith({
    String? fromId,
    String? message,
    String? createdAt,
    bool? isPending,
  }) {
    return ChatMessageModel(
      fromId: fromId ?? this.fromId,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      isPending: isPending ?? this.isPending,
    );
  }
}
