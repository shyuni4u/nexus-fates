class AppConstants {
  // Supabase Configuration
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // Celtic Cross positions
  static const List<String> celticCrossPositions = [
    'Present Situation',
    'Challenge/Cross',
    'Distant Past/Foundation',
    'Recent Past',
    'Possible Outcome',
    'Near Future',
    'Your Approach',
    'External Influences',
    'Hopes and Fears',
    'Final Outcome',
  ];

  // App Settings
  static const int maxQuestionLength = 200;
  static const int cardCount = 10;
  static const String spreadType = 'Celtic Cross';

  // Colors
  static const int primaryColor = 0xFF2D1B69;
  static const int secondaryColor = 0xFF6C5CE7;
  static const int accentColor = 0xFFFFD700;
}