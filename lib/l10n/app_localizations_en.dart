// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Converter';

  @override
  String get recorded => 'Recorded';

  @override
  String get emptyRecords => 'No records';

  @override
  String get error => 'Error';

  @override
  String get saveSuccess => 'Save successful';

  @override
  String get ok => 'OK';

  @override
  String get history => 'History';

  @override
  String get saveAsCsv => 'Save as CSV';

  @override
  String get addToHistory => 'Add to history';

  @override
  String get deleteItem => 'Delete item';

  @override
  String get confirmClear => 'Confirm clear';

  @override
  String get confirmClearMessage =>
      'Are you sure you want to clear all history?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get clear => 'Clear';

  @override
  String get historyCleared => 'History cleared';

  @override
  String get configuration => 'Configuration';

  @override
  String get fpsLabel => 'Frame rate (FPS)';

  @override
  String get frames => 'Frames';

  @override
  String get dropFrameMode => 'Drop frame mode';

  @override
  String get smpteTimecode => 'SMPTE TIMECODE';

  @override
  String get seconds => 'Seconds';

  @override
  String get minutes => 'Minutes';

  @override
  String get hours => 'Hours';

  @override
  String get settings => 'Settings';

  @override
  String get settingsContent => 'Settings content';

  @override
  String get historyContent => 'History content';

  @override
  String get themeSettings => 'Theme Settings';

  @override
  String get framesSpecified => 'Specify frames';

  @override
  String savedToPath(String path) {
    return 'Saved to $path';
  }

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get newestFirst => 'Newest first';

  @override
  String get oldestFirst => 'Oldest first';

  @override
  String get clearAllRecords => 'Clear all records';

  @override
  String get recordDeleted => 'Record deleted';

  @override
  String get undo => 'Undo';

  @override
  String get appearanceExperience => 'Appearance & Experience';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get reverseLayout => 'Reverse layout';

  @override
  String get reverseLayoutSubtitle =>
      'Switch positions of timecode and parameter panels';

  @override
  String get about => 'About';

  @override
  String get versionInfo => 'Version info';

  @override
  String get githubRepo => 'GitHub repository';
}
