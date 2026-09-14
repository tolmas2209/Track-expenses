import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:track_expenses/gen/assets.gen.dart';
import 'package:track_expenses/service/permission_service.dart';
import 'package:track_expenses/widgets/bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigator(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));

    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomBar()),
    );
  }

  @override
  void initState() {
    navigator(context);
    PermissionService.requestLocationPermission();
    super.initState();
  }@override
  void dispose() {
    super.dispose();
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
