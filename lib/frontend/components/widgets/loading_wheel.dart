import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class MyLoadingWheel extends StatefulWidget {
  const MyLoadingWheel({super.key});

  @override
  State<MyLoadingWheel> createState() => _MyLoadingWheelState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyLoadingWheelState extends State<MyLoadingWheel>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late TickerProvider vsync;
  @override
  void initState() {
    setState(() {
      vsync = this;
      animation = AnimationController(
          vsync: vsync, duration: const Duration(milliseconds: 1200));
    });

    super.initState();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SpinKitSpinningLines(
          color: constants.mainBackColor, size: 50.0, controller: animation),
    );
  }
}
