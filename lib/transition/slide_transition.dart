import 'dart:ui';

import 'package:flutter/cupertino.dart';

class SlideTransitionPageRoute extends PageRouteBuilder {
  Transition transition;
  SlideTransitionPageRoute(
      {required page,
      required this.transition,
      required Duration duration,
      RouteSettings? settings})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: duration,
            reverseTransitionDuration: duration,
            settings: settings,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              Tween<Offset> tweenOffset;

              if (transition == Transition.left) {
                tweenOffset =
                    Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero);
              } else if (transition == Transition.right) {
                tweenOffset =
                    Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero);
              } else if (transition == Transition.bottom) {
                tweenOffset =
                    Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero);
              } else {
                tweenOffset =
                    Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero);
              }
              var animationOffset = tweenOffset.animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInCirc));
              return SlideTransition(
                position: animationOffset,
                child: child,
              );
            });
}

enum Transition { top, bottom, left, right }
