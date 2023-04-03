// ignore_for_file: public_member_api_docs, sort_constructors_first
class Contact {
  final String firstName;
  final String email;
  final String? lastName;
  final String? photoURL;
  final String? phoneNumber;
  final String uid;

  Contact({
    required this.firstName,
    required this.email,
    this.lastName,
    this.photoURL,
    this.phoneNumber,
    required this.uid,
  });
}
