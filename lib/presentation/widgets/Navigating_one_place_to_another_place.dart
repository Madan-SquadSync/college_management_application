import 'package:flutter/widgets.dart';

class NavigatingOnePlaceToAnotherPlace {
  void navigatePage(BuildContext context, var screen) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        var tween = Tween(begin: 0.0, end: 1.0);
        var opacityAnimation = animation.drive(tween);
        return FadeTransition(
          opacity: opacityAnimation,
          child: screen,
        );
      },
    ));
  }

  void navigatePageDeletePervious(BuildContext context, var screen) {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        var tween = Tween(begin: 0.0, end: 1.0);
        var opacityAnimation = animation.drive(tween);
        return FadeTransition(
          opacity: opacityAnimation,
          child: screen,
        );
      },
    ));
  }
}
