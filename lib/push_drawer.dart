import 'dart:async';

import 'package:flutter/material.dart';

class PushDrawer extends StatefulWidget {
  final Widget drawer;
  final Widget child;
  final int swipeSensitivity;
  final double drawerRatio;
  final Color overlayColor;
  final double overlayOpacity;
  final int animationDuration;
  final Curve animationCurve;
  final FutureOr<void> Function()? onClose;
  final FutureOr<void> Function()? onOpen;

  PushDrawer({
    Key? key,
    required this.drawer,
    required this.child,
    this.swipeSensitivity = 25,
    this.drawerRatio = 0.8,
    this.overlayColor = Colors.black,
    this.overlayOpacity = 0.5,
    this.animationDuration = 300,
    this.animationCurve = Curves.ease,
    this.onClose,
    this.onOpen,
  }) : super(key: key);
  @override
  PushDrawerState createState() => PushDrawerState();
}

class PushDrawerState extends State<PushDrawer> {
  bool _opened = false;

  Future<void> open() async {
    setState(() {
      _opened = true;
    });
    if (widget.onOpen != null) {
      await widget.onOpen!();
    }
  }

  Future<void> close() async {
    setState(() {
      _opened = false;
    });
    if (widget.onClose != null) {
      await widget.onClose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final drawerWidth = width * widget.drawerRatio;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > widget.swipeSensitivity) {
          open();
        } else if (details.delta.dx < -widget.swipeSensitivity) {
          close();
        }
      },
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            AnimatedPositioned(
              width: drawerWidth,
              height: height,
              left: _opened ? 0 : -drawerWidth,
              duration: Duration(milliseconds: widget.animationDuration),
              curve: widget.animationCurve,
              child: widget.drawer,
            ),
            AnimatedPositioned(
              height: height,
              width: width,
              left: _opened ? drawerWidth : 0,
              duration: Duration(milliseconds: widget.animationDuration),
              curve: widget.animationCurve,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  widget.child,
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: widget.animationDuration),
                    switchInCurve: widget.animationCurve,
                    switchOutCurve: widget.animationCurve,
                    child: _opened
                        ? GestureDetector(
                            onTap: close,
                            child: Container(
                              color: widget.overlayColor.withOpacity(
                                widget.overlayOpacity,
                              ),
                            ),
                          )
                        : null,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
