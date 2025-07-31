import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'services/ad_service.dart';
import 'services/supabase_service.dart';
import 'providers/app_provider.dart';
import 'constants/app_constants.dart';
import 'utils/log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
    logger.i('Environment variables loaded');
  } catch (e) {
    logger.w('Warning: Could not load .env file: $e');
    logger.i('Using development mode with mock services');
  }
  
  // Initialize services
  await _initializeServices();
  
  runApp(const NexusFatesApp());
}

Future<void> _initializeServices() async {
  try {
    // Initialize Supabase service (mock version for development)
    final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? 'mock_url';
    final supabaseKey = dotenv.env['SUPABASE_ANON_KEY'] ?? 'mock_key';
    await SupabaseService().initialize(supabaseUrl, supabaseKey);
    
    // Initialize Ad service (mock version for development)
    if (!kIsWeb) {
      await AdService().initialize();
    }
    
    logger.i('All services initialized successfully');  
  } catch (e) {
    logger.e('Error initializing services: $e');
    logger.i('Continuing with mock services');
  }
}

class NexusFatesApp extends StatelessWidget {
  const NexusFatesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Nexus Fates',
        
        // Localization
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('ko'), // Korean
          Locale('ja'), // Japanese
          Locale('es'), // Spanish
        ],
        
        theme: ThemeData(
          primarySwatch: MaterialColor(
            AppConstants.primaryColor,
            const <int, Color>{
              50: Color(0xFFE8E4F3),
              100: Color(0xFFC5BCE1),
              200: Color(0xFF9F90CD),
              300: Color(0xFF7864B9),
              400: Color(0xFF5C42AA),
              500: Color(0xFF2D1B69),
              600: Color(0xFF3F1F9B),
              700: Color(0xFF371B91),
              800: Color(0xFF2F1787),
              900: Color(0xFF200F75),
            },
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'System',
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}