import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../services/auth_service.dart';
import '../services/temperature_converter_service.dart';
import 'profile_screen.dart';
import 'temperature_converter_screen.dart';
import 'settings_screen.dart';
import 'image_gallery_screen.dart';
import 'login_screen.dart';

// Main home screen with navigation drawer
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = AuthService();
  int _selectedIndex = 0;

  // Navigate to a specific screen
  void _navigateToScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of screens for navigation
  List<Widget> get _screens => [
    _DashboardScreen(onNavigate: _navigateToScreen),
    const ProfileScreen(),
    const TemperatureConverterScreen(),
    const SettingsScreen(),
    const ImageGalleryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUserModel;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(AppConstants.appName),
        leading: _selectedIndex > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => _navigateToScreen(0),
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.logout();
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      drawer: NavigationDrawer(
        backgroundColor: AppConstants.surfaceColor,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          Navigator.pop(context); // Close drawer
        },
        children: [
          // User header
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: AppConstants.primaryColor,
            ),
            accountName: Text(
              user?.displayName ?? 'User',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                (user?.email ?? 'U')[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  color: AppConstants.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Navigation items
          const NavigationDrawerDestination(
            icon: Icon(Icons.dashboard),
            label: Text('Dashboard'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.person),
            label: Text('Profile'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.thermostat),
            label: Text('Temperature Converter'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.image),
            label: Text('Image Gallery'),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}

// Dashboard screen showing unified all-in-one experience
class _DashboardScreen extends StatefulWidget {
  final Function(int) onNavigate;
  
  const _DashboardScreen({required this.onNavigate});

  @override
  State<_DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<_DashboardScreen> {
  final _tempController = TextEditingController();
  String _fromScale = 'Celsius';
  String _toScale = 'Fahrenheit';
  String _convertedTemp = '--';

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }

  void _quickConvert() {
    final value = double.tryParse(_tempController.text);
    if (value == null) {
      setState(() => _convertedTemp = '--');
      return;
    }
    
    final result = TemperatureConverterService.convert(value, _fromScale, _toScale);
    setState(() => _convertedTemp = '${result.toStringAsFixed(1)}°${_toScale == 'Celsius' ? 'C' : _toScale == 'Fahrenheit' ? 'F' : 'K'}');
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUserModel;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Integrated User Profile Header
          Card(
            color: AppConstants.primaryColor.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.mediumPadding),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppConstants.primaryColor,
                    child: Text(
                      (user?.email ?? 'U')[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.mediumPadding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back!',
                          style: AppConstants.subheadingStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? '',
                          style: AppConstants.labelStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.person),
                    color: AppConstants.primaryColor,
                    onPressed: () => widget.onNavigate(1),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.largePadding),
          
          // Quick Temperature Converter
          Text(
            'Quick Temperature Converter',
            style: AppConstants.subheadingStyle,
          ),
          const SizedBox(height: AppConstants.mediumPadding),
          Card(
            color: Colors.orange.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.mediumPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Input temperature
                  TextField(
                    controller: _tempController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _quickConvert(),
                    style: AppConstants.bodyStyle,
                    decoration: InputDecoration(
                      labelText: 'Enter Temperature',
                      labelStyle: AppConstants.labelStyle,
                      filled: true,
                      fillColor: AppConstants.surfaceColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // From scale dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppConstants.surfaceColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: _fromScale,
                      isExpanded: true,
                      underline: const SizedBox(),
                      style: AppConstants.bodyStyle,
                      dropdownColor: AppConstants.surfaceColor,
                      items: ['Celsius', 'Fahrenheit', 'Kelvin']
                          .map((s) => DropdownMenuItem(value: s, child: Text('From: $s')))
                          .toList(),
                      onChanged: (v) {
                        setState(() => _fromScale = v!);
                        _quickConvert();
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Arrow icon
                  const Center(
                    child: Icon(Icons.arrow_downward, color: Colors.orange, size: 20),
                  ),
                  const SizedBox(height: 8),
                  
                  // To scale dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppConstants.surfaceColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: _toScale,
                      isExpanded: true,
                      underline: const SizedBox(),
                      style: AppConstants.bodyStyle,
                      dropdownColor: AppConstants.surfaceColor,
                      items: ['Celsius', 'Fahrenheit', 'Kelvin']
                          .map((s) => DropdownMenuItem(value: s, child: Text('To: $s')))
                          .toList(),
                      onChanged: (v) {
                        setState(() => _toScale = v!);
                        _quickConvert();
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Result display
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Result:',
                          style: AppConstants.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _convertedTemp,
                          style: AppConstants.headingStyle.copyWith(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Full converter link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => widget.onNavigate(2),
                      icon: const Icon(Icons.open_in_new, size: 16),
                      label: const Text('Full Converter'),
                      style: TextButton.styleFrom(foregroundColor: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.largePadding),
          
          // Image Gallery Preview
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Image Gallery Preview',
                style: AppConstants.subheadingStyle,
              ),
              TextButton(
                onPressed: () => widget.onNavigate(4),
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.mediumPadding),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    color: AppConstants.surfaceColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    child: Image.network(
                      'https://picsum.photos/seed/${index + 10}/200',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator(color: AppConstants.primaryColor));
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppConstants.largePadding),
          
          // Quick Stats Row
          Text(
            'Quick Access',
            style: AppConstants.subheadingStyle,
          ),
          const SizedBox(height: AppConstants.mediumPadding),
          Row(
            children: [
              Expanded(
                child: _MiniFeatureCard(
                  icon: Icons.thermostat,
                  label: 'Converter',
                  color: Colors.orange,
                  onTap: () => widget.onNavigate(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _MiniFeatureCard(
                  icon: Icons.image,
                  label: 'Gallery',
                  color: Colors.purple,
                  onTap: () => widget.onNavigate(4),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _MiniFeatureCard(
                  icon: Icons.settings,
                  label: 'Settings',
                  color: Colors.green,
                  onTap: () => widget.onNavigate(3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Mini feature card for quick access
class _MiniFeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MiniFeatureCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppConstants.labelStyle.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// Quick access card widget
class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: AppConstants.smallPadding),
              Text(
                title,
                style: AppConstants.bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
