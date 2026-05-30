import 'package:flutter/material.dart';

class ScaleFadeRoute extends PageRouteBuilder {
  final Widget page;

  ScaleFadeRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 220),
          reverseTransitionDuration: const Duration(milliseconds: 180),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 0.96,
                  end: 1.0,
                ).animate(curvedAnimation),
                child: child,
              ),
            );
          },
        );
}
