import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

// Simple authentication service wrapping Supabase auth
class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Get current user
  User? get currentUser => _supabase.auth.currentUser;

  // Check if user is logged in
  bool get isLoggedIn => currentUser != null;

  // Get current user as UserModel
  UserModel? get currentUserModel {
    if (currentUser == null) return null;
    return UserModel(
      id: currentUser!.id,
      email: currentUser!.email ?? '',
      displayName: currentUser!.userMetadata?['display_name'],
    );
  }

  // Register new user
  Future<String?> register(String email, String password) async {
    try {
      await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return null; // Success
    } catch (e) {
      // Return actual error for debugging
      return 'Error: ${e.toString()}';
    }
  }

  // Login user
  Future<String?> login(String email, String password) async {
    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } catch (e) {
      return 'Invalid email or password';
    }
  }

  // Logout user
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  // Get current authentication state
  UserAuthState get authState {
    if (isLoggedIn) {
      return UserAuthState.authenticated;
    } else {
      return UserAuthState.unauthenticated;
    }
  }
}
