import 'package:edu_advisor/l10n/app_localizations.dart';

class Validators {
  const Validators._();

  static String? name(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.nameRequired;
    if (value.length < 3) return l10n.nameMinLength;
    return null;
  }

  static String? email(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.emailRequired;
    if (!value.contains('@')) return l10n.validEmailRequired;
    return null;
  }

  static String? password(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.passwordRequired;
    if (value.length < 6) return l10n.passwordSixCharacters;
    return null;
  }

  static String? confirmPassword(
    String? value,
    String password,
    AppLocalizations l10n,
  ) {
    if (value == null || value.isEmpty) return l10n.confirmPasswordRequired;
    if (value != password) return l10n.passwordsDoNotMatch;
    return null;
  }

  static String? validateCode(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.codeRequired;
    if (value.length != 6) return l10n.codeSixDigits;
    if (!RegExp(r'^\d+$').hasMatch(value)) return l10n.codeDigitsOnly;
    return null;
  }
}
