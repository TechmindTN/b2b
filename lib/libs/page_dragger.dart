import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:siyou_b2b/libs/pager_indicator.dart';


class PageDragger extends StatefulWidget {
  final int currentIndex;
  final bool canDragLeftToRight;
  final bool canDragRightToLeft;
  final int pageLength;
  final String mainPageRoute;
  final StreamController<SlideUpdate> slideUpdateStream;
  final Function onDone;

  PageDragger({
    this.mainPageRoute,
    this.pageLength,
    this.currentIndex,
    this.canDragLeftToRight,
    this.canDragRightToLeft,
    this.slideUpdateStream,
    this.onDone,
  });

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  static const FULL_TRANSITION_PX = 300.0;

  int nextPageIndex;
  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0.0;

  onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart.dx - newPosition.dx;
      if (dx > 0.0 && widget.canDragRightToLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0.0 && widget.canDragLeftToRight) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }

      if (slideDirection != SlideDirection.none) {
        slidePercent = (dx / FULL_TRANSITION_PX).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }

      widget.slideUpdateStream
          .add(SlideUpdate(UpdateType.dragging, slideDirection, slidePercent));
    }
  }

  onDragEnd(DragEndDetails details) {
    if (slideDirection == SlideDirection.none &&
        widget.currentIndex == widget.pageLength) {
      widget.onDone != null
          ? widget.onDone()
          : Navigator.pushReplacementNamed(context, widget.mainPageRoute);
    } else {
      widget.slideUpdateStream.add(SlideUpdate(
        UpdateType.doneDragging,
        SlideDirection.none,
        0.0,
      ));
    }
    dragStart = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
    );
  }
}

class AnimatedPageDragger {
  static const PERCENT_PER_MILLISECOND = 0.005;

  final slideDirection;
  final transitionGoal;

  AnimationController completionAnimationController;

  AnimatedPageDragger({
    this.slideDirection,
    this.transitionGoal,
    slidePercent,
    StreamController<SlideUpdate> slideUpdateStream,
    TickerProvider vsync,
  }) {
    final startSlidePercent = slidePercent;
    var endSlidePercent;
    var duration;

    if (transitionGoal == TransitionGoal.open) {
      endSlidePercent = 1.0;
      final slideRemaining = 1.0 - slidePercent;
      duration = Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round());
    } else {
      endSlidePercent = 0.0;
      duration = Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round());
    }

    completionAnimationController =
        AnimationController(duration: duration, vsync: vsync)
          ..addListener(() {
            slidePercent = lerpDouble(
              startSlidePercent,
              endSlidePercent,
              completionAnimationController.value,
            );

            slideUpdateStream.add(SlideUpdate(
              UpdateType.animating,
              slideDirection,
              slidePercent,
            ));
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              slideUpdateStream.add(SlideUpdate(
                UpdateType.doneAnimating,
                slideDirection,
                endSlidePercent,
              ));
            }
          });
  }

  run() {
    completionAnimationController.forward(from: 0.0);
  }

  dispose() {
    completionAnimationController.dispose();
  }
}

enum TransitionGoal {
  open,
  close,
}

enum UpdateType {
  dragging,
  doneDragging,
  animating,
  doneAnimating,
}

class SlideUpdate {
  final updateType;
  final direction;
  final slidePercent;

  SlideUpdate(
    this.updateType,
    this.direction,
    this.slidePercent,
  );
}
