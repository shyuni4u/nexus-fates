import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';

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
    Locale('es'),
    Locale('ja'),
    Locale('ko'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Nexus Fates'**
  String get appTitle;

  /// Title for the home screen
  ///
  /// In en, this message translates to:
  /// **'Tarot Reading'**
  String get homeScreenTitle;

  /// Title for question input screen
  ///
  /// In en, this message translates to:
  /// **'Ask Your Question'**
  String get questionInputTitle;

  /// Hint text for question input field
  ///
  /// In en, this message translates to:
  /// **'What would you like guidance on?'**
  String get questionInputHint;

  /// Example question 1
  ///
  /// In en, this message translates to:
  /// **'What should I focus on in my career?'**
  String get questionInputExample1;

  /// Example question 2
  ///
  /// In en, this message translates to:
  /// **'How can I improve my relationships?'**
  String get questionInputExample2;

  /// Example question 3
  ///
  /// In en, this message translates to:
  /// **'What obstacles should I be aware of?'**
  String get questionInputExample3;

  /// Title for card selection screen
  ///
  /// In en, this message translates to:
  /// **'Draw Your Cards'**
  String get cardSelectionTitle;

  /// Button text to shuffle cards
  ///
  /// In en, this message translates to:
  /// **'Shuffle Cards'**
  String get shuffleCards;

  /// Button text to draw cards
  ///
  /// In en, this message translates to:
  /// **'Draw Cards'**
  String get drawCards;

  /// Button text to watch ad for reading
  ///
  /// In en, this message translates to:
  /// **'Watch Ad to View Reading'**
  String get watchAdToViewReading;

  /// Button text to view reading result
  ///
  /// In en, this message translates to:
  /// **'View Reading'**
  String get viewReading;

  /// Title for reading result screen
  ///
  /// In en, this message translates to:
  /// **'Your Celtic Cross Reading'**
  String get readingTitle;

  /// Button text to save reading
  ///
  /// In en, this message translates to:
  /// **'Save Reading'**
  String get saveReading;

  /// Button text to start new reading
  ///
  /// In en, this message translates to:
  /// **'New Reading'**
  String get newReading;

  /// Title for history screen
  ///
  /// In en, this message translates to:
  /// **'Reading History'**
  String get historyTitle;

  /// Message when no reading history exists
  ///
  /// In en, this message translates to:
  /// **'No readings yet'**
  String get noHistory;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Generic error label
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Button text to retry action
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Button text to cancel action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button text for OK action
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Button text to sign in
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Button text to sign out
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Settings menu title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Celtic Cross position 1
  ///
  /// In en, this message translates to:
  /// **'Present Situation'**
  String get celticCrossPosition1;

  /// Celtic Cross position 2
  ///
  /// In en, this message translates to:
  /// **'Challenge/Cross'**
  String get celticCrossPosition2;

  /// Celtic Cross position 3
  ///
  /// In en, this message translates to:
  /// **'Distant Past/Foundation'**
  String get celticCrossPosition3;

  /// Celtic Cross position 4
  ///
  /// In en, this message translates to:
  /// **'Recent Past'**
  String get celticCrossPosition4;

  /// Celtic Cross position 5
  ///
  /// In en, this message translates to:
  /// **'Possible Outcome'**
  String get celticCrossPosition5;

  /// Celtic Cross position 6
  ///
  /// In en, this message translates to:
  /// **'Immediate Future'**
  String get celticCrossPosition6;

  /// Celtic Cross position 7
  ///
  /// In en, this message translates to:
  /// **'Your Approach'**
  String get celticCrossPosition7;

  /// Celtic Cross position 8
  ///
  /// In en, this message translates to:
  /// **'External Influences'**
  String get celticCrossPosition8;

  /// Celtic Cross position 9
  ///
  /// In en, this message translates to:
  /// **'Hopes and Fears'**
  String get celticCrossPosition9;

  /// Celtic Cross position 10
  ///
  /// In en, this message translates to:
  /// **'Final Outcome'**
  String get celticCrossPosition10;

  /// Indicates a card is reversed
  ///
  /// In en, this message translates to:
  /// **'Reversed'**
  String get reversed;

  /// Message shown while ad is loading
  ///
  /// In en, this message translates to:
  /// **'Loading advertisement...'**
  String get adLoadingMessage;

  /// Message when ad is not ready
  ///
  /// In en, this message translates to:
  /// **'Advertisement not ready, please try again later'**
  String get adNotReady;

  /// Character count for input fields
  ///
  /// In en, this message translates to:
  /// **'{count} / {limit} characters'**
  String characterCount(int count, int limit);

  /// Error message when question exceeds character limit
  ///
  /// In en, this message translates to:
  /// **'Question is too long. Please keep it under {limit} characters.'**
  String questionTooLong(int limit);

  /// Error message when question is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter a question before proceeding.'**
  String get questionRequired;
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
      <String>['en', 'es', 'ja', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
