// models/user_model.dart
class UserModel {
  final String uid;
  final String userName;
  final String email;
  final String pfp;
  final bool isPremium;

  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.isPremium,
    required this.pfp,
  });
}
