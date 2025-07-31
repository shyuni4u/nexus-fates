// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '넥서스 운명';

  @override
  String get homeScreenTitle => '타로 리딩';

  @override
  String get questionInputTitle => '질문을 입력하세요';

  @override
  String get questionInputHint => '어떤 지침을 받고 싶으신가요?';

  @override
  String get questionInputExample1 => '직업에서 무엇에 집중해야 할까요?';

  @override
  String get questionInputExample2 => '인간관계를 어떻게 개선할 수 있을까요?';

  @override
  String get questionInputExample3 => '어떤 장애물을 조심해야 할까요?';

  @override
  String get cardSelectionTitle => '카드를 뽑으세요';

  @override
  String get shuffleCards => '카드 섞기';

  @override
  String get drawCards => '카드 뽑기';

  @override
  String get watchAdToViewReading => '광고 시청 후 리딩 보기';

  @override
  String get viewReading => '리딩 보기';

  @override
  String get readingTitle => '켈틱 크로스 리딩 결과';

  @override
  String get saveReading => '리딩 저장';

  @override
  String get newReading => '새 리딩';

  @override
  String get historyTitle => '리딩 기록';

  @override
  String get noHistory => '아직 리딩 기록이 없습니다';

  @override
  String get loading => '로딩 중...';

  @override
  String get error => '오류';

  @override
  String get retry => '다시 시도';

  @override
  String get cancel => '취소';

  @override
  String get ok => '확인';

  @override
  String get signIn => '로그인';

  @override
  String get signOut => '로그아웃';

  @override
  String get email => '이메일';

  @override
  String get password => '비밀번호';

  @override
  String get settings => '설정';

  @override
  String get language => '언어';

  @override
  String get celticCrossPosition1 => '현재 상황';

  @override
  String get celticCrossPosition2 => '도전/교차';

  @override
  String get celticCrossPosition3 => '먼 과거/기초';

  @override
  String get celticCrossPosition4 => '최근 과거';

  @override
  String get celticCrossPosition5 => '가능한 결과';

  @override
  String get celticCrossPosition6 => '가까운 미래';

  @override
  String get celticCrossPosition7 => '당신의 접근법';

  @override
  String get celticCrossPosition8 => '외부 영향';

  @override
  String get celticCrossPosition9 => '희망과 두려움';

  @override
  String get celticCrossPosition10 => '최종 결과';

  @override
  String get reversed => '역방향';

  @override
  String get adLoadingMessage => '광고 로딩 중...';

  @override
  String get adNotReady => '광고가 준비되지 않았습니다. 잠시 후 다시 시도해주세요.';

  @override
  String characterCount(int count, int limit) {
    return '$count / $limit 글자';
  }

  @override
  String questionTooLong(int limit) {
    return '질문이 너무 깁니다. $limit자 이내로 작성해주세요.';
  }

  @override
  String get questionRequired => '진행하기 전에 질문을 입력해주세요.';
}
