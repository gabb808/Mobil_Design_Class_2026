class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String senderPhotoUrl;
  final String content;
  final DateTime createdAt;
  bool isRead;
  final bool isExchangeProposal;
  final String? exchangeArticleId;
  final String? exchangeArticleName;
  final String? exchangeArticlePhotoUrl;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.senderPhotoUrl,
    required this.content,
    required this.createdAt,
    this.isRead = false,
    this.isExchangeProposal = false,
    this.exchangeArticleId,
    this.exchangeArticleName,
    this.exchangeArticlePhotoUrl,
  });

  bool get isMine => senderId == '2'; // Marie est l'utilisateur courant

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? '',
      conversationId: json['conversationId'] ?? '',
      senderId: json['senderId'] ?? '',
      senderName: json['senderName'] ?? '',
      senderPhotoUrl: json['senderPhotoUrl'] ?? '',
      content: json['content'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      isRead: json['isRead'] ?? false,
      isExchangeProposal: json['isExchangeProposal'] ?? false,
      exchangeArticleId: json['exchangeArticleId'],
      exchangeArticleName: json['exchangeArticleName'],
      exchangeArticlePhotoUrl: json['exchangeArticlePhotoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversationId': conversationId,
      'senderId': senderId,
      'senderName': senderName,
      'senderPhotoUrl': senderPhotoUrl,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
      'isExchangeProposal': isExchangeProposal,
      'exchangeArticleId': exchangeArticleId,
      'exchangeArticleName': exchangeArticleName,
      'exchangeArticlePhotoUrl': exchangeArticlePhotoUrl,
    };
  }
}
