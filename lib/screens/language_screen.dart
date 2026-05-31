import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/locale_provider.dart';
import 'package:flickreview/l10n/app_localizations.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.chooseLanguage), centerTitle: true),

      body: Column(
        children: [
          // ENGLISH
          RadioListTile<String>(
            value: 'en',

            groupValue: localeProvider.locale.languageCode,

            title: Text(AppLocalizations.of(context)!.english),

            secondary: const Icon(Icons.language),

            onChanged: (value) {
              localeProvider.setLocale(const Locale('en'));
            },
          ),

          // INDONESIA
          RadioListTile<String>(
            value: 'id',

            groupValue: localeProvider.locale.languageCode,

            title: Text(AppLocalizations.of(context)!.indonesian),

            secondary: const Icon(Icons.language),

            onChanged: (value) {
              localeProvider.setLocale(const Locale('id'));
            },
          ),

          // JAPANESE
          RadioListTile<String>(
            value: 'ja',

            groupValue: localeProvider.locale.languageCode,

            title: Text(AppLocalizations.of(context)!.japanese),

            secondary: const Icon(Icons.language),

            onChanged: (value) {
              localeProvider.setLocale(const Locale('ja'));
            },
          ),
        ],
      ),
    );
  }
}
