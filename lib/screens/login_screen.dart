import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/cyan_button.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;

  const LoginScreen({super.key, required this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (emailController.text.trim().isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }
    widget.onLogin();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: AppColors.backgroundColor,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500, maxHeight: 850),
              margin: EdgeInsets.all(constraints.maxWidth > 600 ? 24 : 8),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(38),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: const Text(
                      'CROWDFUND PORTAL',
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.send_outlined,
                                color: AppColors.cyan,
                                size: 55,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Welcome Back',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Sign in to support projects and make an impact',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 36),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              decoration: loginDecoration('surname@gmail.com', Icons.email_outlined),
                            ),
                            const SizedBox(height: 18),
                            TextField(
                              controller: passwordController,
                              obscureText: obscurePassword,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              decoration: loginDecoration(
                                'Password',
                                Icons.lock_outline,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.white70,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Password recovery is not configured yet.'),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(color: AppColors.cyan, fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: AppColors.cyan, thickness: 0.5),
                            const SizedBox(height: 24),
                            CyanButton(text: 'Log in', onPressed: login),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialIcon(icon: Icons.facebook),
                        SizedBox(width: 20),
                        SocialIcon(icon: Icons.g_mobiledata, size: 28),
                        SizedBox(width: 20),
                        SocialIcon(icon: Icons.apple),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

InputDecoration loginDecoration(String hint, IconData prefixIcon, {Widget? suffixIcon}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.white60, fontSize: 13),
    prefixIcon: Icon(prefixIcon, color: Colors.white70, size: 20),
    filled: true,
    fillColor: const Color(0xFF2D4696),
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: AppColors.cyan, width: 1.5),
    ),
  );
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const SocialIcon({super.key, required this.icon, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
      child: Icon(icon, size: size, color: AppColors.primaryBlue),
    );
  }
}
