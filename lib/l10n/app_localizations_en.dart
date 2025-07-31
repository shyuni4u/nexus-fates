// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nexus Fates';

  @override
  String get homeScreenTitle => 'Tarot Reading';

  @override
  String get questionInputTitle => 'Ask Your Question';

  @override
  String get questionInputHint => 'What would you like guidance on?';

  @override
  String get questionInputExample1 => 'What should I focus on in my career?';

  @override
  String get questionInputExample2 => 'How can I improve my relationships?';

  @override
  String get questionInputExample3 => 'What obstacles should I be aware of?';

  @override
  String get cardSelectionTitle => 'Draw Your Cards';

  @override
  String get shuffleCards => 'Shuffle Cards';

  @override
  String get drawCards => 'Draw Cards';

  @override
  String get watchAdToViewReading => 'Watch Ad to View Reading';

  @override
  String get viewReading => 'View Reading';

  @override
  String get readingTitle => 'Your Celtic Cross Reading';

  @override
  String get saveReading => 'Save Reading';

  @override
  String get newReading => 'New Reading';

  @override
  String get historyTitle => 'Reading History';

  @override
  String get noHistory => 'No readings yet';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get signIn => 'Sign In';

  @override
  String get signOut => 'Sign Out';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get celticCrossPosition1 => 'Present Situation';

  @override
  String get celticCrossPosition2 => 'Challenge/Cross';

  @override
  String get celticCrossPosition3 => 'Distant Past/Foundation';

  @override
  String get celticCrossPosition4 => 'Recent Past';

  @override
  String get celticCrossPosition5 => 'Possible Outcome';

  @override
  String get celticCrossPosition6 => 'Immediate Future';

  @override
  String get celticCrossPosition7 => 'Your Approach';

  @override
  String get celticCrossPosition8 => 'External Influences';

  @override
  String get celticCrossPosition9 => 'Hopes and Fears';

  @override
  String get celticCrossPosition10 => 'Final Outcome';

  @override
  String get reversed => 'Reversed';

  @override
  String get adLoadingMessage => 'Loading advertisement...';

  @override
  String get adNotReady => 'Advertisement not ready, please try again later';

  @override
  String characterCount(int count, int limit) {
    return '$count / $limit characters';
  }

  @override
  String questionTooLong(int limit) {
    return 'Question is too long. Please keep it under $limit characters.';
  }

  @override
  String get questionRequired => 'Please enter a question before proceeding.';
}
