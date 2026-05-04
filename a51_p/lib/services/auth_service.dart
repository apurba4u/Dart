import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Stream to listen to auth state changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // Get current user
  User? get currentUser => _supabase.auth.currentUser;

  // Sign In with Email & Password
  Future<AuthResponse> signIn({required String email, required String password}) async {
    return await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  // Sign Up and Create Profile
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String gender,
    required int age,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user != null) {
      // Create profile record in 'profiles' table
      await _supabase.from('profiles').insert({
        'id': user.id,
        'name': name,
        'email': email,
        'gender': gender,
        'age': age,
      });
    }
  }

  // Fetch Profile
  Future<Map<String, dynamic>?> fetchProfile() async {
    final user = currentUser;
    if (user != null) {
      final data = await _supabase.from('profiles').select().eq('id', user.id).maybeSingle();
      return data;
    }
    return null;
  }

  // Sign Out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
