import 'package:flutter/material.dart';

import '../../home/home/ui/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(milliseconds: 3000), () => {navigateToHome(context)});
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Text(
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
            "SPLASH SCREEN"),
      ),
    );
  }

  void navigateToHome(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (__) => const HomePage()));
  }
}
