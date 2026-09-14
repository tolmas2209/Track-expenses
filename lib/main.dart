import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/const/themes/app_themes.dart';
import 'package:track_expenses/providers/home_screen_provider.dart';
import 'package:track_expenses/providers/onboarding_provider.dart';
import 'package:track_expenses/screens/onboarding_screen.dart';
import 'package:track_expenses/service/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Track Expenses",
      theme: AppThemes.LightTheme,
      home: OnboardingScreen(),
    );
  }
}
