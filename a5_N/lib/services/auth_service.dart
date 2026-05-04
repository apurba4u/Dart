import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Login
  Future<AuthResponse> signIn(String email, String password) async {
    return await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  // Register
  Future<AuthResponse> signUp(String email, String password) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  // Create Profile
  Future<void> createProfile({
    required String id,
    required String name,
    required String favoriteTeam,
    required String favoriteClub,
  }) async {
    await _supabase.from('profiles').insert({
      'id': id,
      'name': name,
      'favourite_team': favoriteTeam,
      'favourite_club': favoriteClub,
    });
  }

  // Get Profile
  Future<Map<String, dynamic>?> getProfile() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    return await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();
  }

  // Sign Out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Current Session
  Session? get currentSession => _supabase.auth.currentSession;
}
