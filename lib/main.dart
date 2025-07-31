import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/ad_service.dart';
import 'constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services (skip ads on web)
  if (!kIsWeb) {
    await AdService().initialize();
  }
  
  runApp(const NexusFatesApp());
}

class NexusFatesApp extends StatelessWidget {
  const NexusFatesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus Fates',
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
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}