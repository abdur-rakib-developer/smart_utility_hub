import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../services/auth_service.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';
import 'register_screen.dart';
import 'home_screen.dart';

// Login screen for existing users
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Simple email format validation
  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  // Handle login button press
  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Basic validation
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
        _isLoading = false;
      });
      return;
    }

    // Check email format
    if (!_isValidEmail(email)) {
      setState(() {
        _errorMessage = 'Please enter a valid email format';
        _isLoading = false;
      });
      return;
    }

    // Attempt login
    final error = await _authService.login(email, password);

    if (mounted) {
      if (error == null) {
        // Login successful - navigate to home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        // Login failed - show error
        setState(() {
          _errorMessage = error;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppConstants.largePadding * 2),
              // Title
              Text(
                AppConstants.loginTitle,
                style: AppConstants.headingStyle,
              ),
              const SizedBox(height: AppConstants.smallPadding),
              Text(
                'Sign in to continue',
                style: AppConstants.labelStyle,
              ),
              const SizedBox(height: AppConstants.largePadding * 2),
              
              // Email field
              CustomTextField(
                label: 'Email',
                controller: _emailController,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppConstants.mediumPadding),
              
              // Password field
              CustomTextField(
                label: 'Password',
                controller: _passwordController,
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: AppConstants.mediumPadding),
              
              // Error message
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(AppConstants.mediumPadding),
                  decoration: BoxDecoration(
                    color: AppConstants.errorColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: AppConstants.errorColor),
                      const SizedBox(width: AppConstants.smallPadding),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: AppConstants.errorColor),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_errorMessage != null) const SizedBox(height: AppConstants.mediumPadding),
              
              // Login button
              PrimaryButton(
                text: 'Login',
                onPressed: _handleLogin,
                isLoading: _isLoading,
              ),
              const SizedBox(height: AppConstants.mediumPadding),
              
              // Register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppConstants.labelStyle,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      'Register',
                      style: AppConstants.labelStyle.copyWith(
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
