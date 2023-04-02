// ignore_for_file: public_member_api_docs, sort_constructors_first
class Contact {
  final String name;
  final String id;
  final String? avatar;
  final String? lastSeen;
  final int status;

  Contact({
    required this.name,
    required this.id,
    this.avatar,
    this.lastSeen,
    required this.status,
  });
}
