import 'package:flickreview/screens/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // DARK MODE TOGGLE
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            value: themeController.isDarkMode, 
            onChanged: (value) {
              themeController.toggleTheme(value); 
            },
          ),

          const Divider(),

          // CHANGE PASSWORD
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChangePasswordScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
