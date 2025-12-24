import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../services/auth_service.dart';

// Settings screen showing app info and user details
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUserModel;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: AppConstants.headingStyle,
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'App configuration and information',
            style: AppConstants.labelStyle,
          ),
          const SizedBox(height: AppConstants.largePadding),
          
          // Account Section
          _SectionHeader(title: 'Account'),
          const SizedBox(height: AppConstants.mediumPadding),
          _SettingsTile(
            icon: Icons.email,
            title: 'Email',
            subtitle: user?.email ?? 'Not available',
          ),
          _SettingsTile(
            icon: Icons.person,
            title: 'User ID',
            subtitle: user?.id.substring(0, 12) ?? 'N/A',
          ),
          const SizedBox(height: AppConstants.largePadding),
          
          // App Info Section
          _SectionHeader(title: 'App Information'),
          const SizedBox(height: AppConstants.mediumPadding),
          _SettingsTile(
            icon: Icons.info,
            title: 'App Name',
            subtitle: AppConstants.appName,
          ),
          _SettingsTile(
            icon: Icons.code,
            title: 'Version',
            subtitle: '1.0.0',
          ),
          _SettingsTile(
            icon: Icons.build,
            title: 'Build',
            subtitle: 'Flutter 3.0+',
          ),
          const SizedBox(height: AppConstants.largePadding),
          
          // Features Section
          _SectionHeader(title: 'Integrated Features'),
          const SizedBox(height: AppConstants.mediumPadding),
          _FeatureCard(
            icon: Icons.lock,
            title: 'Authentication',
            description: 'Supabase-powered login & registration',
            color: Colors.blue,
          ),
          const SizedBox(height: AppConstants.mediumPadding),
          _FeatureCard(
            icon: Icons.thermostat,
            title: 'Temperature Converter',
            description: 'Convert between °C, °F, and K',
            color: Colors.orange,
          ),
          const SizedBox(height: AppConstants.mediumPadding),
          _FeatureCard(
            icon: Icons.image,
            title: 'Image Gallery',
            description: 'Browse images from Picsum API',
            color: Colors.purple,
          ),
          const SizedBox(height: AppConstants.mediumPadding),
          _FeatureCard(
            icon: Icons.person,
            title: 'User Profile',
            description: 'View your account details',
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

// Section header widget
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppConstants.subheadingStyle,
    );
  }
}

// Settings tile widget
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppConstants.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppConstants.primaryColor),
        title: Text(title, style: AppConstants.bodyStyle),
        subtitle: Text(
          subtitle,
          style: AppConstants.labelStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

// Feature card widget
class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.mediumPadding),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: AppConstants.mediumPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppConstants.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.smallPadding),
                  Text(
                    description,
                    style: AppConstants.labelStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
