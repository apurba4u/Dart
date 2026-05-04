import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants.dart';
import '../theme.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authService = AuthService();
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;
  late String _randomQuote;

  @override
  void initState() {
    super.initState();
    _randomQuote = AppConstants.philosophicalQuotes[Random().nextInt(AppConstants.philosophicalQuotes.length)];
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final data = await _authService.fetchProfile();
      if (mounted) {
        setState(() {
          _profileData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load profile'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  Future<void> _logout() async {
    await _authService.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: AppTheme.gradientBackground,
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        _randomQuote,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(duration: 1000.ms).slideY(begin: -0.2, end: 0),
                      const SizedBox(height: 60),
                      if (_profileData != null)
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 5,
                              )
                            ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                _profileData!['name'] ?? 'Wanderer',
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32),
                                textAlign: TextAlign.center,
                              ).animate().fadeIn(delay: 200.ms),
                              const SizedBox(height: 8),
                              Text(
                                _profileData!['email'] ?? '',
                                style: const TextStyle(color: Colors.white70, fontSize: 16),
                                textAlign: TextAlign.center,
                              ).animate().fadeIn(delay: 300.ms),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.0),
                                child: Divider(color: Colors.white24),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildInfoItem('Gender', _profileData!['gender'] ?? 'Unknown').animate().fadeIn(delay: 400.ms),
                                  _buildInfoItem('Age', _profileData!['age']?.toString() ?? 'Unknown').animate().fadeIn(delay: 500.ms),
                                ],
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0)
                      else
                        const Center(
                          child: Text(
                            'No profile found',
                            style: TextStyle(color: Colors.white70, fontSize: 18),
                          ),
                        ),
                      const SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: _logout,
                        child: const Text(AppConstants.logoutButton),
                      ).animate().fadeIn(delay: 800.ms).scale(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
