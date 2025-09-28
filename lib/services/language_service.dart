import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'selected_language';
  static const String _countryKey = 'selected_country';

  /// Save the selected locale to SharedPreferences
  static Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, locale.languageCode);
    await prefs.setString(_countryKey, locale.countryCode ?? '');
  }

  /// Get the saved locale from SharedPreferences
  static Future<Locale?> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey);
    final countryCode = prefs.getString(_countryKey);

    if (languageCode != null) {
      return Locale(
        languageCode,
        countryCode?.isEmpty == true ? null : countryCode,
      );
    }
    return null;
  }

  /// Initialize and set the saved locale or default
  static Future<void> initializeLanguage() async {
    final savedLocale = await getSavedLocale();

    if (savedLocale != null) {
      // Set the saved locale
      Get.updateLocale(savedLocale);
    } else {
      // Set default locale and save it
      final defaultLocale = _getDefaultLocale();
      Get.updateLocale(defaultLocale);
      await saveLocale(defaultLocale);
    }
  }

  /// Update locale and save to preferences
  static Future<void> changeLocale(Locale locale) async {
    Get.updateLocale(locale);
    await saveLocale(locale);
  }

  /// Get default locale based on device locale or fallback to English
  static Locale _getDefaultLocale() {
    final deviceLocale = Get.deviceLocale;

    // Check if device locale is Arabic
    if (deviceLocale?.languageCode == 'ar') {
      return const Locale('ar', 'SA');
    }

    // Default to English
    return const Locale('en', 'US');
  }

  /// Get all supported locales
  static List<Locale> get supportedLocales => [
    const Locale('en', 'US'),
    const Locale('ar', 'SA'),
  ];

  /// Check if a locale is supported
  static bool isSupportedLocale(Locale locale) {
    return supportedLocales.any(
      (supportedLocale) =>
          supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode,
    );
  }
}
