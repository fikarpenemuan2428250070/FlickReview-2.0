import 'package:flickreview/screens/change_password_screen.dart';
import 'package:flickreview/screens/language_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_controller.dart';

import 'package:flickreview/l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
      ),

      body: ListView(
        children: [
          // DARK MODE TOGGLE
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),

            title: Text(AppLocalizations.of(context)!.darkMode),

            value: themeController.isDarkMode,

            onChanged: (value) {
              themeController.toggleTheme(value);
            },
          ),

          const Divider(),

          // LANGUAGE
          ListTile(
            leading: const Icon(Icons.language),

            title: Text(AppLocalizations.of(context)!.language),

            trailing: const Icon(Icons.arrow_forward_ios, size: 16),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LanguageScreen()),
              );
            },
          ),

          const Divider(),

          // CHANGE PASSWORD
          ListTile(
            leading: const Icon(Icons.lock_outline),

            title: Text(AppLocalizations.of(context)!.changePassword),

            trailing: const Icon(Icons.arrow_forward_ios, size: 16),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
