import 'package:flutter/material.dart';

/// Helper class for internationalization utilities
class I18nHelper {
  /// Get the localized string for Celtic Cross positions
  static String getCelticCrossPosition(BuildContext context, int position) {
    final locale = Localizations.localeOf(context);
    
    // Temporary implementation until AppLocalizations is properly generated
    final positions = _getPositionsForLocale(locale);
    
    if (position >= 1 && position <= 10) {
      return positions[position - 1];
    }
    return 'Position $position';
  }
  
  static List<String> _getPositionsForLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'ko':
        return [
          '현재 상황',
          '도전/교차',
          '먼 과거/기초',
          '최근 과거',
          '가능한 결과',
          '가까운 미래',
          '당신의 접근법',
          '외부 영향',
          '희망과 두려움',
          '최종 결과',
        ];
      case 'ja':
        return [
          '現在の状況',
          'チャレンジ/クロス',
          '遠い過去/基盤',
          '最近の過去',
          '可能な結果',
          '近い未来',
          'あなたのアプローチ',
          '外部の影響',
          '希望と恐れ',
          '最終結果',
        ];
      case 'es':
        return [
          'Situación Presente',
          'Desafío/Cruz',
          'Pasado Lejano/Fundación',
          'Pasado Reciente',
          'Resultado Posible',
          'Futuro Inmediato',
          'Tu Enfoque',
          'Influencias Externas',
          'Esperanzas y Miedos',
          'Resultado Final',
        ];
      default: // English
        return [
          'Present Situation',
          'Challenge/Cross',
          'Distant Past/Foundation',
          'Recent Past',
          'Possible Outcome',
          'Immediate Future',
          'Your Approach',
          'External Influences',
          'Hopes and Fears',
          'Final Outcome',
        ];
    }
  }
  
  /// Get localized Celtic Cross positions list
  static List<String> getCelticCrossPositions(BuildContext context) {
    return List.generate(10, (index) => getCelticCrossPosition(context, index + 1));
  }
  
  /// Get sample questions in current locale
  static List<String> getSampleQuestions(BuildContext context) {
    final locale = Localizations.localeOf(context);
    
    switch (locale.languageCode) {
      case 'ko':
        return [
          '직업에서 무엇에 집중해야 할까요?',
          '인간관계를 어떻게 개선할 수 있을까요?',
          '어떤 장애물을 조심해야 할까요?',
        ];
      case 'ja':
        return [
          'キャリアで何に集中すべきでしょうか？',
          '人間関係をどのように改善できますか？',
          'どのような障害に注意すべきでしょうか？',
        ];
      case 'es':
        return [
          '¿En qué debería enfocarme en mi carrera?',
          '¿Cómo puedo mejorar mis relaciones?',
          '¿De qué obstáculos debería estar consciente?',
        ];
      default: // English
        return [
          'What should I focus on in my career?',
          'How can I improve my relationships?',
          'What obstacles should I be aware of?',
        ];
    }
  }
  
  /// Format character count message
  static String formatCharacterCount(BuildContext context, int count, int limit) {
    final locale = Localizations.localeOf(context);
    
    switch (locale.languageCode) {
      case 'ko':
        return '$count / $limit 글자';
      case 'ja':
        return '$count / $limit 文字';
      case 'es':
        return '$count / $limit caracteres';
      default: // English
        return '$count / $limit characters';
    }
  }
  
  /// Get question validation error message
  static String? validateQuestion(BuildContext context, String? question, int maxLength) {
    final locale = Localizations.localeOf(context);
    
    if (question == null || question.trim().isEmpty) {
      switch (locale.languageCode) {
        case 'ko':
          return '진행하기 전에 질문을 입력해주세요.';
        case 'ja':
          return '続行する前に質問を入力してください。';
        case 'es':
          return 'Por favor ingresa una pregunta antes de continuar.';
        default:
          return 'Please enter a question before proceeding.';
      }
    }
    
    if (question.length > maxLength) {
      switch (locale.languageCode) {
        case 'ko':
          return '질문이 너무 깁니다. $maxLength자 이내로 작성해주세요.';
        case 'ja':
          return '質問が長すぎます。$maxLength文字以内で入力してください。';
        case 'es':
          return 'La pregunta es muy larga. Manténla bajo $maxLength caracteres.';
        default:
          return 'Question is too long. Please keep it under $maxLength characters.';
      }
    }
    
    return null;
  }
  
  /// Check if current locale is RTL (Right-to-Left)
  static bool isRTL(BuildContext context) {
    final locale = Localizations.localeOf(context);
    // Add RTL language codes here as needed
    const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.contains(locale.languageCode);
  }
  
  /// Get current locale language code
  static String getCurrentLanguageCode(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }
  
  /// Get current locale country code
  static String? getCurrentCountryCode(BuildContext context) {
    return Localizations.localeOf(context).countryCode;
  }
  
  /// Get language display name
  static String getLanguageDisplayName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'ko':
        return '한국어';
      case 'ja':
        return '日本語';
      case 'es':
        return 'Español';
      default:
        return languageCode.toUpperCase();
    }
  }
  
  /// Available languages
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ko'),
    Locale('ja'),
    Locale('es'),
  ];
}