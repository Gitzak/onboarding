import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_logo.dart';
import '../home/home_screen.dart';
import 'onboarding_data.dart';
import 'onboarding_page.dart';
import 'widgets/onboarding_button.dart';
import 'widgets/onboarding_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleButton() async {
    if (_currentIndex < onboardingPages.length - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 460),
        curve: Curves.easeInOutCubic,
      );
      return;
    }

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
          child: Column(
            children: [
              const _BrandHeader(),
              const SizedBox(height: 4),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) =>
                      setState(() => _currentIndex = index),
                  itemCount: onboardingPages.length,
                  itemBuilder: (context, index) => OnboardingPage(
                    data: onboardingPages[index],
                    isActive: index == _currentIndex,
                  ),
                ),
              ),
              OnboardingIndicator(
                currentIndex: _currentIndex,
                itemCount: onboardingPages.length,
              ),
              const SizedBox(height: 24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 240),
                child: OnboardingButton(
                  key: ValueKey(_currentIndex),
                  label: _currentIndex == onboardingPages.length - 1
                      ? 'Get Started'
                      : 'Next',
                  onPressed: _handleButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppLogo(size: 36),
        SizedBox(width: 9),
        Text(
          'VOLTWAY',
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 15,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.4,
          ),
        ),
      ],
    );
  }
}
