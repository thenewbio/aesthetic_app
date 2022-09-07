import 'dart:async';
import 'package:aesthetic_app/screens/onboarding_screen.dart';
import 'package:aesthetic_app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_providers.dart';
import 'home_screen.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen> {
  void checkSignIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn) {
      Route newRoute = MaterialPageRoute(builder: (_) => const MyHomePage());
      Navigator.pushReplacement(context, newRoute);
      return;
    }
    Route newRoute =
        MaterialPageRoute(builder: (_) => const OnboardingScreen());
    Navigator.pushReplacement(context, newRoute);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      checkSignIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/splash.png', width: 300, height: 300),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'World\'s Largest Aesthetic App',
              style: TextStyle(),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: 20,
              height: 20,
              child: LoadingView(),
            ),
          ],
        ),
      ),
    );
  }
}
