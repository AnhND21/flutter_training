import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Message {
  String senderId;
  String recipientId;
  String createdAt;
  String content;
  String? images;

  Message({
    required this.senderId,
    required this.recipientId,
    required this.createdAt,
    required this.content,
    this.images,
  });

  Message copyWith({
    String? senderId,
    String? recipientId,
    String? createdAt,
    String? content,
    String? images,
  }) {
    return Message(
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'recipientId': recipientId,
      'createdAt': createdAt,
      'content': content,
      'images': images,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      recipientId: map['recipientId'] as String,
      createdAt: map['createdAt'] as String,
      content: map['content'] as String,
      images: map['images'] != null ? map['images'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(senderId: $senderId, recipientId: $recipientId, createdAt: $createdAt, content: $content, images: $images)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.senderId == senderId &&
        other.recipientId == recipientId &&
        other.createdAt == createdAt &&
        other.content == content &&
        other.images == images;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        recipientId.hashCode ^
        createdAt.hashCode ^
        content.hashCode ^
        images.hashCode;
  }
}
