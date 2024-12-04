class UserModel {
  final String name;
  final String userId;
  final String profilePicture; // URL or path to the profile picture
  final DateTime date;

  UserModel({
    required this.name,
    required this.userId,
    required this.profilePicture,
    required this.date,
  });
}
