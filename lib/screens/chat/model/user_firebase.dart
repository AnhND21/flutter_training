class User {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] ?? "",
        firstName: json['firstName'] ?? "",
        lastName: json['lastName'] ?? "",
        email: json['email'] ?? "",
        imageUrl: json['imageUrl'] ?? "",
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'imageUrl': imageUrl,
      };
  factory User.empty() => const User(
        id: "",
        firstName: "",
        lastName: "",
        email: "",
        imageUrl: "",
      );

  List<Object?> get props => [id, firstName, lastName, email, imageUrl];
}
