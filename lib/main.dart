import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:nexus_fates/screens/intro_screen.dart';

void main() {
  runApp(const MyApp());
}

// A custom scroll behavior that enables mouse dragging
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus Fates Tarot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      scrollBehavior: MyCustomScrollBehavior(), // Apply the custom scroll behavior
      home: const IntroScreen(),
    );
  }
}