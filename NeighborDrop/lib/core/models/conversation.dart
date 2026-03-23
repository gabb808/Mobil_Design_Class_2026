import 'message.dart';

class Conversation {
  final String id;
  final String otherUserId;
  final String otherUserName;
  final String otherUserPhotoUrl;
  final String articleId;
  final String articleName;
  final String articlePhotoUrl;
  final List<Message> messages;
  final DateTime updatedAt;

  Conversation({
    required this.id,
    required this.otherUserId,
    required this.otherUserName,
    required this.otherUserPhotoUrl,
    required this.articleId,
    required this.articleName,
    required this.articlePhotoUrl,
    required this.messages,
    required this.updatedAt,
  });

  Message? get lastMessage =>
      messages.isNotEmpty ? messages.last : null;

  int get unreadCount =>
      messages.where((m) => !m.isRead && !m.isMine).length;
}
