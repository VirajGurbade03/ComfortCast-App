import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 4 seconds and then navigate to the sign-in page
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushNamed(context, "/SignIn");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlinkAndShineEffect(
          child: Image.asset(
            'lib/assets/images/comfortcast_logoT.png', // Path to your image
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class BlinkAndShineEffect extends StatefulWidget {
  final Widget child;

  const BlinkAndShineEffect({required this.child, super.key});

  @override
  _BlinkAndShineEffectState createState() => _BlinkAndShineEffectState();
}

class _BlinkAndShineEffectState extends State<BlinkAndShineEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    // Define the opacity animation
    _opacityAnimation =
        Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.white.withOpacity(0.5), Colors.transparent],
        stops: const [0.5, 1.0],
        tileMode: TileMode.clamp,
      ).createShader(bounds),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: widget.child,
      ),
    );
  }
}
