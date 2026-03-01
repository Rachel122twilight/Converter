import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('zh'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Converter'**
  String get appTitle;

  /// Snackbar message when a record is added
  ///
  /// In en, this message translates to:
  /// **'Recorded'**
  String get recorded;

  /// Message shown when there are no records to export
  ///
  /// In en, this message translates to:
  /// **'No records'**
  String get emptyRecords;

  /// Error dialog title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Success dialog title when file is saved
  ///
  /// In en, this message translates to:
  /// **'Save successful'**
  String get saveSuccess;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// History drawer title and tooltip
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// Tooltip for save button
  ///
  /// In en, this message translates to:
  /// **'Save as CSV'**
  String get saveAsCsv;

  /// Tooltip for add button
  ///
  /// In en, this message translates to:
  /// **'Add to history'**
  String get addToHistory;

  /// Tooltip for delete button
  ///
  /// In en, this message translates to:
  /// **'Delete item'**
  String get deleteItem;

  /// Dialog title for clearing history
  ///
  /// In en, this message translates to:
  /// **'Confirm clear'**
  String get confirmClear;

  /// Dialog message for clearing history
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all history?'**
  String get confirmClearMessage;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Clear button text
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Snackbar message when history is cleared
  ///
  /// In en, this message translates to:
  /// **'History cleared'**
  String get historyCleared;

  /// Configuration section title
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configuration;

  /// Label for FPS input field
  ///
  /// In en, this message translates to:
  /// **'Frame rate (FPS)'**
  String get fpsLabel;

  /// Frames section title
  ///
  /// In en, this message translates to:
  /// **'Frames'**
  String get frames;

  /// Switch label for drop frame mode
  ///
  /// In en, this message translates to:
  /// **'Drop frame mode'**
  String get dropFrameMode;

  /// SMPTE timecode display title
  ///
  /// In en, this message translates to:
  /// **'SMPTE TIMECODE'**
  String get smpteTimecode;

  /// Seconds label in result section
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// Minutes label in result section
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// Hours label in result section
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// Settings title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Content text for settings page
  ///
  /// In en, this message translates to:
  /// **'Settings content'**
  String get settingsContent;

  /// Content text for history page
  ///
  /// In en, this message translates to:
  /// **'History content'**
  String get historyContent;

  /// Theme settings title
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettings;

  /// Title for frames specification section
  ///
  /// In en, this message translates to:
  /// **'Specify frames'**
  String get framesSpecified;

  /// Message shown when file is saved to a path
  ///
  /// In en, this message translates to:
  /// **'Saved to {path}'**
  String savedToPath(String path);

  /// Label for today's date
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Label for yesterday's date
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Tooltip for sorting newest first
  ///
  /// In en, this message translates to:
  /// **'Newest first'**
  String get newestFirst;

  /// Tooltip for sorting oldest first
  ///
  /// In en, this message translates to:
  /// **'Oldest first'**
  String get oldestFirst;

  /// Tooltip for clearing all records
  ///
  /// In en, this message translates to:
  /// **'Clear all records'**
  String get clearAllRecords;

  /// Snackbar message when a record is deleted
  ///
  /// In en, this message translates to:
  /// **'Record deleted'**
  String get recordDeleted;

  /// Undo button text
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// Settings group title for appearance and experience
  ///
  /// In en, this message translates to:
  /// **'Appearance & Experience'**
  String get appearanceExperience;

  /// Switch label for dark mode
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// Switch label for reverse layout
  ///
  /// In en, this message translates to:
  /// **'Reverse layout'**
  String get reverseLayout;

  /// Subtitle for reverse layout switch
  ///
  /// In en, this message translates to:
  /// **'Switch positions of timecode and parameter panels'**
  String get reverseLayoutSubtitle;

  /// Settings group title for about section
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Title for version information
  ///
  /// In en, this message translates to:
  /// **'Version info'**
  String get versionInfo;

  /// Title for GitHub repository link
  ///
  /// In en, this message translates to:
  /// **'GitHub repository'**
  String get githubRepo;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
