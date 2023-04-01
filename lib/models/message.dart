// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  final String? content;
  final String createdAt;
  final int status;
  final List<Photo>? photos;
  final int senderId;

  Message(
      {this.content,
      this.photos,
      required this.createdAt,
      required this.senderId,
      required this.status});
}

class Photo {
  final String url;
  final String name;
  final String type;
  Photo({
    required this.url,
    required this.name,
    required this.type,
  });
}
