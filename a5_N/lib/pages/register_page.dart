import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import '../theme.dart';
import '../constants.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _teamController = TextEditingController();
  final _clubController = TextEditingController();
  
  final _authService = AuthService();
  bool _isLoading = false;

  Future<void> _register() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    try {
      // 1. Validate inputs
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final name = _nameController.text.trim();
      final team = _teamController.text.trim();
      final club = _clubController.text.trim();
      
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        throw Exception("Please fill all required fields");
      }

      // 2. Create user via Supabase
      final response = await _authService.signUp(email, password);
      
      final user = response.user;
      if (user == null) {
        // Check for specific errors
        if (response.session == null && response.user == null) {
          throw Exception("Registration failed - check your internet connection");
        }
        throw Exception("User creation failed");
      }

      // 3. Wait briefly to ensure auth session is ready
      await Future.delayed(const Duration(milliseconds: 500));

      // 4. Insert into profiles table
      try {
        await _authService.createProfile(
          id: user.id,
          name: name,
          favoriteTeam: team,
          favoriteClub: club,
        );
      } catch (profileError) {
        // If profile creation fails, try to clean up
        throw Exception("Profile creation failed: $profileError");
      }

      // 5. Wait for profile to be inserted
      await Future.delayed(const Duration(milliseconds: 300));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll("AuthException: ", "")),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: 1.0,
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: AppTheme.glassDecoration,
                    child: Column(
                      children: [
                        const Text(
                          "JOIN THE CLUB",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentGold,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildTextField(_nameController, "Full Name", Icons.person),
                        const SizedBox(height: 16),
                        _buildTextField(_emailController, "Email", Icons.email),
                        const SizedBox(height: 16),
                        _buildTextField(_passwordController, "Password", Icons.lock, isPassword: true),
                        const SizedBox(height: 16),
                        _buildTextField(_teamController, "Favourite Team", Icons.sports_soccer),
                        const SizedBox(height: 16),
                        _buildTextField(_clubController, "Favourite Club", Icons.stadium),
                        const SizedBox(height: 32),
                        _buildRegisterButton(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? ", style: TextStyle(color: Colors.white70)),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                "Login",
                                style: TextStyle(color: AppColors.accentGold, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  AppConstants.footerText,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: AppColors.accentGold),
                labelText: label,
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _register,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 8,
          shadowColor: AppColors.red.withOpacity(0.5),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "REGISTER",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
      ),
    );
  }
}
