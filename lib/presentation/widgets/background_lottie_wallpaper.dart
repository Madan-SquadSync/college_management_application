import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BackgroundLottieWallpaper extends StatelessWidget {
  const BackgroundLottieWallpaper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: LottieBuilder.asset(
        "asserts/lottie/wallpaper.json",
        fit: BoxFit.fill,
        animate: true,
        repeat: true,
        filterQuality: FilterQuality.low,
        key: const ObjectKey("Background"),
      ),
    );
  }
}
