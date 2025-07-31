import 'package:flutter/material.dart';
import '../models/tarot_reading.dart';
import '../models/tarot_card.dart';
import '../services/supabase_service.dart';
import '../services/tarot_service.dart';
import '../services/ad_service.dart';
import '../utils/development_helper.dart';

class AppProvider with ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  final AdService _adService = AdService();
  
  // App state
  bool _isLoading = false;
  String? _error;
  
  // Reading state
  List<TarotCard> _currentCards = [];
  String _currentQuestion = '';
  String _currentInterpretation = '';
  List<TarotReading> _readingHistory = [];
  
  // Ad state
  bool _hasWatchedAd = false;
  
  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<TarotCard> get currentCards => _currentCards;
  String get currentQuestion => _currentQuestion;
  String get currentInterpretation => _currentInterpretation;
  List<TarotReading> get readingHistory => _readingHistory;
  bool get hasWatchedAd => _hasWatchedAd;
  bool get isLoggedIn => _supabaseService.currentUser != null;
  
  // Methods
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void setError(String? error) {
    _error = error;
    notifyListeners();
  }
  
  void clearError() {
    _error = null;
    notifyListeners();
  }
  
  // Authentication
  Future<bool> signInAnonymously() async {
    try {
      setLoading(true);
      clearError();
      
      final response = await _supabaseService.signInAnonymously();
      if (response.user != null) {
        DevelopmentHelper.successLog('Anonymous sign-in successful');
        await loadReadingHistory();
        return true;
      }
      return false;
    } catch (e) {
      DevelopmentHelper.errorLog('Sign-in failed: $e');
      setError('Failed to sign in: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }
  
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      setLoading(true);
      clearError();
      
      final response = await _supabaseService.signInWithEmail(email, password);
      if (response.user != null) {
        DevelopmentHelper.successLog('Email sign-in successful');
        await loadReadingHistory();
        return true;
      }
      return false;
    } catch (e) {
      DevelopmentHelper.errorLog('Email sign-in failed: $e');
      setError('Failed to sign in: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }
  
  Future<void> signOut() async {
    try {
      await _supabaseService.signOut();
      _readingHistory.clear();
      _currentCards.clear();
      _currentQuestion = '';
      _currentInterpretation = '';
      _hasWatchedAd = false;
      notifyListeners();
      DevelopmentHelper.successLog('Signed out successfully');
    } catch (e) {
      DevelopmentHelper.errorLog('Sign-out failed: $e');
      setError('Failed to sign out: $e');
    }
  }
  
  // Tarot Reading
  Future<bool> generateReading(String question) async {
    try {
      setLoading(true);
      clearError();
      
      _currentQuestion = question;
      
      // Generate Celtic Cross spread
      _currentCards = await TarotService.generateCelticCrossSpread();
      DevelopmentHelper.debugLog('Generated ${_currentCards.length} cards for reading');
      
      // Get AI interpretation
      _currentInterpretation = await _supabaseService.getAIInterpretation(
        question, 
        _currentCards,
      );
      
      DevelopmentHelper.successLog('Reading generated successfully');
      notifyListeners();
      return true;
      
    } catch (e) {
      DevelopmentHelper.errorLog('Failed to generate reading: $e');
      setError('Failed to generate reading: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }
  
  Future<bool> saveCurrentReading() async {
    if (_currentCards.isEmpty || _currentQuestion.isEmpty) {
      setError('No reading to save');
      return false;
    }
    
    try {
      setLoading(true);
      clearError();
      
      final reading = TarotReading(
        question: _currentQuestion,
        cards: _currentCards,
        interpretation: _currentInterpretation,
      );
      
      await _supabaseService.saveReading(reading);
      await loadReadingHistory(); // Refresh history
      
      DevelopmentHelper.successLog('Reading saved successfully');
      return true;
      
    } catch (e) {
      DevelopmentHelper.errorLog('Failed to save reading: $e');
      setError('Failed to save reading: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }
  
  Future<void> loadReadingHistory() async {
    try {
      setLoading(true);
      _readingHistory = await _supabaseService.getUserReadings();
      DevelopmentHelper.debugLog('Loaded ${_readingHistory.length} readings from history');
      notifyListeners();
    } catch (e) {
      DevelopmentHelper.errorLog('Failed to load reading history: $e');
      setError('Failed to load reading history: $e');
    } finally {
      setLoading(false);
    }
  }
  
  // Ad functionality
  Future<bool> watchRewardedAd(BuildContext context) async {
    try {
      setLoading(true);
      clearError();
      
      bool adCompleted;
      
      if (DevelopmentHelper.useMockAds) {
        // Show mock ad dialog for development
        adCompleted = await _adService.showMockRewardedAdDialog(context);
      } else {
        // Show real ad in production
        adCompleted = await _adService.showRewardedAd();
      }
      
      if (adCompleted) {
        _hasWatchedAd = true;
        DevelopmentHelper.successLog('Rewarded ad completed');
        notifyListeners();
        return true;
      } else {
        DevelopmentHelper.debugLog('Rewarded ad skipped or failed');
        return false;
      }
      
    } catch (e) {
      DevelopmentHelper.errorLog('Failed to show rewarded ad: $e');
      setError('Failed to show ad: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }
  
  void resetAdWatchedStatus() {
    _hasWatchedAd = false;
    notifyListeners();
  }
  
  // Utility methods
  void clearCurrentReading() {
    _currentCards.clear();
    _currentQuestion = '';
    _currentInterpretation = '';
    _hasWatchedAd = false;
    notifyListeners();
  }
  
  // Development helpers
  Future<void> quickSignIn() async {
    if (DevelopmentHelper.isDevelopmentMode) {
      await signInAnonymously();
    }
  }
  
  Future<void> generateQuickReading() async {
    if (DevelopmentHelper.isDevelopmentMode && _currentQuestion.isEmpty) {
      final questions = DevelopmentHelper.quickTestQuestions;
      final randomQuestion = questions[DateTime.now().millisecond % questions.length];
      await generateReading(randomQuestion);
    }
  }
}