import 'dart:math';
import 'package:flutter/material.dart';

class FallingStarsBackground extends StatefulWidget {
  final Widget child;

  const FallingStarsBackground({super.key, required this.child});

  @override
  State<FallingStarsBackground> createState() => _FallingStarsBackgroundState();
}

class _FallingStarsBackgroundState extends State<FallingStarsBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Star> _stars = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initStars(MediaQuery.of(context).size);
    });
  }

  void _initStars(Size size) {
    for (int i = 0; i < 50; i++) {
      _stars.add(Star(
        x: _random.nextDouble() * size.width,
        y: _random.nextDouble() * size.height,
        size: _random.nextDouble() * 2 + 1,
        speed: _random.nextDouble() * 2 + 1,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xFF0D0D0D),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: StarsPainter(_stars, _controller.value),
              size: Size.infinite,
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class Star {
  double x;
  double y;
  double size;
  double speed;

  Star({required this.x, required this.y, required this.size, required this.speed});
}

class StarsPainter extends CustomPainter {
  final List<Star> stars;
  final double progress;
  final Paint _paint;

  StarsPainter(this.stars, this.progress) : _paint = Paint()..color = Colors.white.withAlpha(128);

  @override
  void paint(Canvas canvas, Size size) {
    for (var star in stars) {
      double currentY = star.y + (progress * size.height * star.speed);
      if (currentY > size.height) {
        currentY = currentY % size.height;
      }
      canvas.drawCircle(Offset(star.x, currentY), star.size, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarsPainter oldDelegate) => true;
}
