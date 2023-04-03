// ignore_for_file: public_member_api_docs, sort_constructors_first

class Message {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;
  Message({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });
}
