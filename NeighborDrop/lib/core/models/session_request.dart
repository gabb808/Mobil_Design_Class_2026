class SessionRequest {
  final String id;
  final String partnerId;
  final String partnerName;
  final String subject;
  final String timeSlot;
  final String location;
  final String message;
  final String status;
  final DateTime createdAt;

  SessionRequest({
    required this.id,
    required this.partnerId,
    required this.partnerName,
    required this.subject,
    required this.timeSlot,
    required this.location,
    required this.message,
    this.status = 'pending',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
