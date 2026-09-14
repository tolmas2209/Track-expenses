import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:track_expenses/gen/assets.gen.dart';
import 'package:track_expenses/widgets/bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 soniyadan keyin keyingi sahifaga o'tadi
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BottomBar(),
          ), // Keyingi sahifa nomi
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            FadeInDown(child: Image.asset(Assets.images.logo.path)),
            FadeInUp(
              child: Text(
                "Track Expenses",
                style: TextStyle(fontSize: 30, fontWeight: .bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
