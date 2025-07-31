import '../models/tarot_reading.dart';
import '../models/tarot_card.dart';
import '../utils/log.dart';
import 'tarot_service.dart';

// Mock user class for development
class MockUser {
  final String id;
  final String email;
  final DateTime createdAt;

  MockUser({
    required this.id,
    required this.email,
    required this.createdAt,
  });
}

// Mock auth response for development
class MockAuthResponse {
  final MockUser? user;
  final String? error;

  MockAuthResponse({this.user, this.error});
}

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  // Mock data storage
  final List<TarotReading> _mockReadings = [];
  MockUser? _currentUser;
  bool _isInitialized = false;

  Future<void> initialize(String url, String anonKey) async {
    // Mock initialization - just set flag
    await Future.delayed(const Duration(milliseconds: 500));
    _isInitialized = true;
    logger.i('DEV MODE: Using mock Supabase service');
  }

  // Mock Auth methods
  Future<MockAuthResponse> signInWithEmail(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock successful login
    _currentUser = MockUser(
      id: 'mock_user_${email.hashCode}',
      email: email,
      createdAt: DateTime.now(),
    );
    
    return MockAuthResponse(user: _currentUser);
  }

  Future<MockAuthResponse> signUpWithEmail(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock successful signup
    _currentUser = MockUser(
      id: 'mock_user_${email.hashCode}',
      email: email,
      createdAt: DateTime.now(),
    );
    
    return MockAuthResponse(user: _currentUser);
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  MockUser? get currentUser => _currentUser;

  // Mock anonymous login for development
  Future<MockAuthResponse> signInAnonymously() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    _currentUser = MockUser(
      id: 'anonymous_user_${DateTime.now().millisecondsSinceEpoch}',
      email: 'anonymous@example.com',
      createdAt: DateTime.now(),
    );
    
    return MockAuthResponse(user: _currentUser);
  }

  // Mock Reading methods
  Future<void> saveReading(TarotReading reading) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final readingWithId = reading.copyWith(
      id: 'reading_${DateTime.now().millisecondsSinceEpoch}',
      userId: _currentUser?.id ?? 'anonymous',
      createdAt: DateTime.now(),
    );
    
    _mockReadings.add(readingWithId);
    logger.d('DEV MODE: Saved mock reading: ${reading.question}');
  }

  Future<List<TarotReading>> getUserReadings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final userReadings = _mockReadings
        .where((reading) => reading.userId == (_currentUser?.id ?? 'anonymous'))
        .toList();
    
    // Sort by creation date (newest first)
    userReadings.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    
    // Add some sample readings if empty
    if (userReadings.isEmpty && _currentUser != null) {
      await _generateSampleReadings();
      return getUserReadings(); // Recursive call to get the sample data
    }
    
    return userReadings;
  }

  // Generate sample readings for demo
  Future<void> _generateSampleReadings() async {
    final sampleQuestions = [
      'What should I focus on in my career this month?',
      'How can I improve my relationships?',
      'What obstacles should I be aware of?',
    ];
    
    for (int i = 0; i < sampleQuestions.length; i++) {
      final cards = await TarotService.generateCelticCrossSpread();
      final interpretation = await TarotService.getMockGeminiResponse(
        sampleQuestions[i], 
        cards,
      );
      
      final reading = TarotReading(
        id: 'sample_${i}_${DateTime.now().millisecondsSinceEpoch}',
        userId: _currentUser!.id,
        question: sampleQuestions[i],
        cards: cards,
        interpretation: interpretation,
        createdAt: DateTime.now().subtract(Duration(days: i + 1)),
      );
      
      _mockReadings.add(reading);
    }
  }

  // Mock AI interpretation using TarotService
  Future<String> getAIInterpretation(String question, List<TarotCard> cards) async {
    await Future.delayed(const Duration(seconds: 2));
    
    // Use the mock Gemini response from TarotService
    return await TarotService.getMockGeminiResponse(question, cards);
  }

  // Utility method to check if service is properly initialized
  bool get isInitialized => _isInitialized;
  
  // Clear mock data (useful for testing)
  void clearMockData() {
    _mockReadings.clear();
    _currentUser = null;
  }
}