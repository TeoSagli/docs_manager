import 'package:flutter/material.dart';

class MyLoadingWheel extends StatefulWidget {
  const MyLoadingWheel({super.key});

  @override
  State<MyLoadingWheel> createState() => _MyLoadingWheelState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyLoadingWheelState extends State<MyLoadingWheel>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1),
          duration: const Duration(milliseconds: 4000),
          builder: (context, value, _) =>
              CircularProgressIndicator(value: value),
        ));
  }
}
