class ChatMessageModel {
  final String fromId;
  final String message;
  final String createdAt;
  final bool isPending;
  final String? localId;

  ChatMessageModel({
    required this.fromId,
    required this.message,
    required this.createdAt,
    this.isPending = false,
    this.localId,
  });
}
