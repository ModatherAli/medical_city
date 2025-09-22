import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/language_service.dart';

class LanguageSelectionDialog extends StatelessWidget {
  const LanguageSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Get.locale ?? const Locale('en', 'US');

    return AlertDialog(
      title: Text('Language'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<Locale>(
            title: Text('English'.tr),
            subtitle: Text('English'.tr),
            value: const Locale('en', 'US'),
            groupValue: currentLocale,
            onChanged: (Locale? locale) async {
              if (locale != null) {
                await LanguageService.changeLocale(locale);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
          ),
          RadioListTile<Locale>(
            title: const Text('العربية'),
            subtitle: const Text('Arabic'),
            value: const Locale('ar', 'SA'),
            groupValue: currentLocale,
            onChanged: (Locale? locale) async {
              if (locale != null) {
                await LanguageService.changeLocale(locale);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'.tr),
        ),
      ],
    );
  }
}

void showLanguageSelection(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const LanguageSelectionDialog(),
  );
}
