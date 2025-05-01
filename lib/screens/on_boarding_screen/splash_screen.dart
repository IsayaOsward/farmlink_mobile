import 'package:flutter/material.dart';
import '../../utils/image_assets.dart';
import '../../routes/route_names.dart';

class SplashScreen extends StatefulWidget {
  final void Function() onInitializationComplete;

  const SplashScreen({super.key, required this.onInitializationComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Scale animation
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Slide animation
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start animations
    _controller.forward().then((_) {
      widget.onInitializationComplete();
      if (mounted) {
        Navigator.pushReplacementNamed(
            context, FarmLinkRoutes.onBoardingScreen);
      }
    }).catchError((e) {
      print('Animation error: $e');
      widget.onInitializationComplete();
      if (mounted) {
        Navigator.pushReplacementNamed(
            context, FarmLinkRoutes.onBoardingScreen);
      }
    });

    // Fallback timeout to ensure navigation
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onInitializationComplete();
        Navigator.pushReplacementNamed(
            context, FarmLinkRoutes.onBoardingScreen);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50], // Light green background
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Image.asset(
                  ImageAssets.logo,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
                // App Name
                Text(
                  'SMART',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.green,
                        letterSpacing: 10,
                      ),
                ),
                Text(
                  'FarmLink App',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SlideTransition(
        position: _slideAnimation,
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.green[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "All rights reserved\n${DateTime.now().year}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.green,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
