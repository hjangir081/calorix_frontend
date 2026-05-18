import 'package:flutter/material.dart';

class AnimatedNumber extends StatelessWidget {
  final int value;

  const AnimatedNumber({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: const Duration(milliseconds: 600),
      builder: (context, val, child) {
        return Text(
          val.toInt().toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}