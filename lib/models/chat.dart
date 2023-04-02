// ignore_for_file: public_member_api_docs, sort_constructors_first
class Chat {
  final String id;
  final String name;
  final String? avatar;
  final String? lastMessage;
  final String createdAt;
  final String sentAt;
  final int status;
  final int? messageUnread;
  Chat({
    this.avatar,
    this.lastMessage,
    required this.id,
    required this.name,
    required this.createdAt,
    required this.sentAt,
    required this.status,
    this.messageUnread,
  });
}
