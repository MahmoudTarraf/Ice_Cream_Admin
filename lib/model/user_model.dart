class User {
  String userName;
  String? email;
  String phoneNumber;
  String location;
  String? image;

  User({
    required this.email,
    required this.location,
    required this.userName,
    required this.phoneNumber,
    this.image,
  });
}
