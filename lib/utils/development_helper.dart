import 'package:flutter/foundation.dart';
import 'log.dart';

class DevelopmentHelper {
  static const bool isDevelopmentMode = kDebugMode;
  
  // Development flags
  static const bool useMockSupabase = true;
  static const bool useMockAds = true;
  static const bool useMockGemini = true;
  static const bool showDebugLogs = true;
  
  // Mock data configurations
  static const int mockApiDelay = 1000; // milliseconds
  static const double mockFailureRate = 0.05; // 5% failure rate
  
  // Development user credentials
  static const String mockEmail = 'dev@nexusfates.com';
  static const String mockPassword = 'dev123456';
  
  static void debugLog(String message) {
    if (showDebugLogs && isDevelopmentMode) {
      logger.d('DEV: $message');
    }
  }
  
  static void errorLog(String message) {
    if (isDevelopmentMode) {
      logger.e('DEV ERROR: $message');
    }
  }
  
  static void successLog(String message) {
    if (isDevelopmentMode) {
      logger.i('DEV SUCCESS: $message');
    }
  }
  
  // Helper to simulate network delays
  static Future<void> simulateNetworkDelay() async {
    if (isDevelopmentMode) {
      await Future.delayed(Duration(milliseconds: mockApiDelay));
    }
  }
  
  // Get mock data paths
  static const String mockTarotDataPath = 'assets/data/tarot.json';
  
  // Development shortcuts
  static const List<String> quickTestQuestions = [
    'What should I focus on today?',
    'How can I improve my relationships?',
    'What opportunities should I look for?',
    'What challenges am I facing?',
    'How can I achieve my goals?',
  ];
}