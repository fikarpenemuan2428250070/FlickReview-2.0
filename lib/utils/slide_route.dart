import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;

  SlidePageRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            final tween = Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            );

            return SlideTransition(
              position: tween.animate(animation),
              child: child,
            );
          },
        );
}
