import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../services/auth_service.dart';

// Profile screen displaying user information
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUserModel;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      child: Column(
        children: [
          const SizedBox(height: AppConstants.largePadding),
          
          // Profile container with border
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 3, color: AppConstants.primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // User avatar
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppConstants.primaryColor,
                  child: Text(
                    (user?.email ?? 'U')[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Display name or email prefix
                Text(
                  user?.displayName ?? user?.email?.split('@')[0] ?? 'User',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                // User ID
                Text(
                  'ID: ${user?.id.substring(0, 8) ?? 'N/A'}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Profile info card
          SizedBox(
            width: 150,
            height: 150,
            child: Card(
              color: Colors.blueGrey,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.email,
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        user?.email ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: AppConstants.largePadding),
          
          // Account info section
          Card(
            color: AppConstants.surfaceColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.mediumPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Information',
                    style: AppConstants.subheadingStyle,
                  ),
                  const SizedBox(height: AppConstants.mediumPadding),
                  _InfoRow(
                    icon: Icons.email,
                    label: 'Email',
                    value: user?.email ?? 'N/A',
                  ),
                  const Divider(color: Colors.white24),
                  _InfoRow(
                    icon: Icons.fingerprint,
                    label: 'User ID',
                    value: user?.id ?? 'N/A',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Info row widget for profile details
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppConstants.primaryColor, size: 20),
        const SizedBox(width: AppConstants.smallPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppConstants.labelStyle),
              Text(
                value,
                style: AppConstants.bodyStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
