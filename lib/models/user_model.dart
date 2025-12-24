// User model for storing user data from Supabase
class UserModel {
  final String id;
  final String email;
  final String? displayName;

  UserModel({
    required this.id,
    required this.email,
    this.displayName,
  });

  // Create UserModel from Supabase user data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      displayName: json['user_metadata']?['display_name'],
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'display_name': displayName,
    };
  }
}

// Enum to track user authentication state
enum UserAuthState {
  authenticated,
  unauthenticated,
}
