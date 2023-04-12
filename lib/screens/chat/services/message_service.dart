import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  static String collection = 'messages';
  static final _firestore = FirebaseFirestore.instance;

  static Future sendMessage({
    required String content,
    required String senderId,
    required String recipientId,
    String? images,
  }) async {
    await _firestore.collection(collection).add({
      'senderId': senderId,
      'recipientId': recipientId,
      'content': content,
      'images': images,
      'createdAt': DateTime.now(),
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> messageStream() {
    return _firestore
        .collection(collection)
        .orderBy('time', descending: true)
        .snapshots();
  }
}
