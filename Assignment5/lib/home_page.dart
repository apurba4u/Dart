import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'auth_service.dart';
import 'login_page.dart';
import 'widgets/glass_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _authService = AuthService();

  void _logout(BuildContext context) async {
    await _authService.signOut();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return Scaffold(
      backgroundColor: AppConstants.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _logout(context),
            tooltip: AppConstants.logoutButton,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                  child: GlassCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: user?.userMetadata?['avatar_url'] != null
                              ? NetworkImage(user!.userMetadata!['avatar_url'])
                              : null,
                          child: user?.userMetadata?['avatar_url'] == null
                              ? const Icon(Icons.person, size: 50, color: Colors.white54)
                              : null,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          user?.userMetadata?['full_name'] ?? 'No Name Provided',
                          style: GoogleFonts.poppins(
                            color: AppConstants.textColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user?.email ?? 'No Email',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                            border: Border.all(color: Colors.white54),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                              onTap: () => _logout(context),
                              child: Center(
                                child: Text(
                                  AppConstants.logoutButton,
                                  style: GoogleFonts.poppins(
                                    color: AppConstants.textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppConstants.footerText,
                style: GoogleFonts.poppins(
                  color: Colors.white54,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
