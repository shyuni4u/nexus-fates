import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tarot_reading.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  static SupabaseClient get client => Supabase.instance.client;

  Future<void> initialize(String url, String anonKey) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }

  // Auth methods
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    return await client.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

  User? get currentUser => client.auth.currentUser;

  // Reading methods
  Future<void> saveReading(TarotReading reading) async {
    await client
        .from('readings')
        .insert(reading.toJson());
  }

  Future<List<TarotReading>> getUserReadings() async {
    final response = await client
        .from('readings')
        .select()
        .eq('user_id', currentUser!.id)
        .order('created_at', ascending: false);

    return response
        .map<TarotReading>((json) => TarotReading.fromJson(json))
        .toList();
  }

  // AI interpretation
  Future<String> getAIInterpretation(String question, List<Map<String, dynamic>> cards) async {
    final response = await client.functions.invoke(
      'generate-interpretation',
      body: {
        'question': question,
        'cards': cards,
      },
    );

    return response.data['interpretation'];
  }
}