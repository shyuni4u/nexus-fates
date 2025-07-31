// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'ネクサス運命';

  @override
  String get homeScreenTitle => 'タロットリーディング';

  @override
  String get questionInputTitle => '質問を入力してください';

  @override
  String get questionInputHint => 'どのような指導を受けたいですか？';

  @override
  String get questionInputExample1 => 'キャリアで何に集中すべきでしょうか？';

  @override
  String get questionInputExample2 => '人間関係をどのように改善できますか？';

  @override
  String get questionInputExample3 => 'どのような障害に注意すべきでしょうか？';

  @override
  String get cardSelectionTitle => 'カードを引いてください';

  @override
  String get shuffleCards => 'カードをシャッフル';

  @override
  String get drawCards => 'カードを引く';

  @override
  String get watchAdToViewReading => '広告視聴後リーディングを見る';

  @override
  String get viewReading => 'リーディングを見る';

  @override
  String get readingTitle => 'ケルト十字リーディング結果';

  @override
  String get saveReading => 'リーディングを保存';

  @override
  String get newReading => '新しいリーディング';

  @override
  String get historyTitle => 'リーディング履歴';

  @override
  String get noHistory => 'まだリーディング履歴がありません';

  @override
  String get loading => '読み込み中...';

  @override
  String get error => 'エラー';

  @override
  String get retry => '再試行';

  @override
  String get cancel => 'キャンセル';

  @override
  String get ok => 'OK';

  @override
  String get signIn => 'サインイン';

  @override
  String get signOut => 'サインアウト';

  @override
  String get email => 'メール';

  @override
  String get password => 'パスワード';

  @override
  String get settings => '設定';

  @override
  String get language => '言語';

  @override
  String get celticCrossPosition1 => '現在の状況';

  @override
  String get celticCrossPosition2 => 'チャレンジ/クロス';

  @override
  String get celticCrossPosition3 => '遠い過去/基盤';

  @override
  String get celticCrossPosition4 => '最近の過去';

  @override
  String get celticCrossPosition5 => '可能な結果';

  @override
  String get celticCrossPosition6 => '近い未来';

  @override
  String get celticCrossPosition7 => 'あなたのアプローチ';

  @override
  String get celticCrossPosition8 => '外部の影響';

  @override
  String get celticCrossPosition9 => '希望と恐れ';

  @override
  String get celticCrossPosition10 => '最終結果';

  @override
  String get reversed => '逆位置';

  @override
  String get adLoadingMessage => '広告読み込み中...';

  @override
  String get adNotReady => '広告の準備ができていません。しばらくしてから再試行してください。';

  @override
  String characterCount(int count, int limit) {
    return '$count / $limit 文字';
  }

  @override
  String questionTooLong(int limit) {
    return '質問が長すぎます。$limit文字以内で入力してください。';
  }

  @override
  String get questionRequired => '続行する前に質問を入力してください。';
}
