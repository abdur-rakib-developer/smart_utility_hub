import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../services/auth_service.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';

// Registration screen for new users
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  String? _errorMessage;
  bool _isLoading = false;
  bool _registerSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Simple email format validation
  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  // Handle register button press
  Future<void> _handleRegister() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _registerSuccess = false;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Basic validation
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
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

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match';
        _isLoading = false;
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        _errorMessage = 'Password must be at least 6 characters';
        _isLoading = false;
      });
      return;
    }

    // Attempt registration
    final error = await _authService.register(email, password);

    if (mounted) {
      if (error == null) {
        // Success
        setState(() {
          _registerSuccess = true;
          _isLoading = false;
        });
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
      } else {
        // Failed
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                AppConstants.registerTitle,
                style: AppConstants.headingStyle,
              ),
              const SizedBox(height: AppConstants.smallPadding),
              Text(
                'Join Smart Utility Hub today',
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
              
              // Confirm password field
              CustomTextField(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                prefixIcon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: AppConstants.mediumPadding),
              
              // Success message
              if (_registerSuccess)
                Container(
                  padding: const EdgeInsets.all(AppConstants.mediumPadding),
                  decoration: BoxDecoration(
                    color: AppConstants.successColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppConstants.successColor),
                      const SizedBox(width: AppConstants.smallPadding),
                      Expanded(
                        child: Text(
                          'Register Successful',
                          style: const TextStyle(color: AppConstants.successColor),
                        ),
                      ),
                    ],
                  ),
                ),
              
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
              if (_errorMessage != null || _registerSuccess) 
                const SizedBox(height: AppConstants.mediumPadding),
              
              // Register button
              PrimaryButton(
                text: 'Register',
                onPressed: _handleRegister,
                isLoading: _isLoading,
              ),
              const SizedBox(height: AppConstants.mediumPadding),
              
              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: AppConstants.labelStyle,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Login',
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
