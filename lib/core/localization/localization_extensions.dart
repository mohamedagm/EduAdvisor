import 'package:edu_advisor/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension LocalizationBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
