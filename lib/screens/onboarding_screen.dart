import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/const/colors/app_colors.dart';
import 'package:track_expenses/providers/onboarding_provider.dart';
import 'package:track_expenses/screens/splash_screen.dart';
import 'package:track_expenses/widgets/snack_bar_custom.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => OnboardingProvider(),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Expanded(
                  flex: 6,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: context
                        .read<OnboardingProvider>()
                        .pageOzgarganda,
                    itemCount: context
                        .watch<OnboardingProvider>()
                        .malumotlar
                        .length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: Column(
                        spacing: 20,
                        mainAxisAlignment: .end,
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 2000),
                            child: CircleAvatar(
                              radius: 32,
                              backgroundColor: AppColors.secondary,
                              child: SvgPicture.asset(
                                context
                                    .watch<OnboardingProvider>()
                                    .malumotlar[index]["icon"],
                              ),
                            ),
                          ),
                          FadeInDown(
                            duration: Duration(milliseconds: 800),
                            child: Text(
                              context
                                      .watch<OnboardingProvider>()
                                      .malumotlar[index]["title"] ??
                                  "",
                              style: TextStyle(fontSize: 20, fontWeight: .bold),
                            ),
                          ),
                          FadeInDown(
                            duration: Duration(milliseconds: 500),
                            child: Text(
                              context
                                      .watch<OnboardingProvider>()
                                      .malumotlar[index]["description"] ??
                                  "",
                              textAlign: .center,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: .end,
                    children: [
                      FadeInUp(
                        child: Row(
                          mainAxisAlignment: .center,
                          spacing: 6,
                          children: List.generate(
                            context
                                .watch<OnboardingProvider>()
                                .malumotlar
                                .length,
                            (index) => CircleAvatar(
                              radius: 6,
                              backgroundColor:
                                  context
                                          .read<OnboardingProvider>()
                                          .currentPage ==
                                      index
                                  ? AppColors.primary
                                  : AppColors.neutral,
                            ),
                          ),
                        ),
                      ),
                      FadeInUp(
                        delay: Duration(milliseconds: 2000),
                        child: ElevatedButton(
                          onPressed: () {
                            final provider = Provider.of<OnboardingProvider>(
                              context,
                              listen: false,
                            );
                            if (provider.currentPage ==
                                provider.malumotlar.length - 1) {
                              SnackBarCustom.showSuccesSnackBar(
                                context,
                                "Welcome to Track Expenses",
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SplashScreen(),
                                ),
                              );
                            } else {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.decelerate,
                              );
                            }
                          },
                          child: Text(
                            context.read<OnboardingProvider>().currentPage ==
                                    context
                                            .watch<OnboardingProvider>()
                                            .malumotlar
                                            .length -
                                        1
                                ? "Get started"
                                : "Next",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
