// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Adapted from
// https://github.com/flutter/udacity-course/blob/master/unit_converter/unit_converter/lib/backdrop.dart

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

const _kFlingVelocity = 2.0;

class _BackdropPanel extends StatefulWidget {
  const _BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.title,
    this.child,
    this.titleHeight,
    this.padding,
    this.ter,
  }) : super(key: key);

  final Animation ter;
  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget title;
  final Widget child;
  final double titleHeight;
  final EdgeInsets padding;

  @override
  __BackdropPanelState createState() => __BackdropPanelState();
}

class __BackdropPanelState extends State<_BackdropPanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Material(
        elevation: 12.0,
        borderRadius:  BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: widget.onVerticalDragUpdate,
              onVerticalDragEnd: widget.onVerticalDragEnd,
              onTap: widget.onTap,
              child: Container(height: widget.titleHeight, child: widget.title),
            ),
            Divider(
              height: 1.0,
            ),
            Expanded(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}

/// Builds a Backdrop.
///
/// A Backdrop widget has two panels, front and back. The front panel is shown
/// by default, and slides down to show the back panel, from which a user
/// can make a selection. The user can also configure the titles for when the
/// front or back panel is showing.
class Backdrop extends StatefulWidget {
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontHeader;
  final double frontPanelOpenHeight;
  final double frontHeaderHeight;
  final bool frontHeaderVisibleClosed;
  final EdgeInsets frontPanelPadding;
  final ValueNotifier<bool> panelVisible;
  final Animation ter;

  Backdrop(
      {@required this.frontLayer,
      @required this.backLayer,
      this.frontPanelOpenHeight = 0.0,
      this.frontHeaderHeight = 48.0,
      this.frontPanelPadding = const EdgeInsets.all(0.0),
      this.frontHeaderVisibleClosed = true,
      this.panelVisible,
      this.ter,
      this.frontHeader})
      : assert(frontLayer != null),
        assert(backLayer != null);

  @override
  createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with TickerProviderStateMixin {
  final _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller, animationController2;
  Animation transformationAnim, sterer;

  @override
  void initState() {
    super.initState();

    animationController2 =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      // value of 0 hides the panel; value of 1 fully shows the panel
      value: (widget.panelVisible?.value ?? true) ? 1.0 : 0.0,
      vsync: this,
    );

    sterer = Tween(begin: 10.0, end: 200.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.ease));

    transformationAnim = BorderRadiusTween(
      begin: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      end: BorderRadius.only(
        topLeft: Radius.circular(2),
        topRight: Radius.circular(2)
      ),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    // Listen on the toggle value notifier if it's not null

    widget.panelVisible?.addListener(_subscribeToValueNotifier);

    // Ensure that the value notifier is updated when the panel is opened or closed
    if (widget.panelVisible != null) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed)
          widget.panelVisible.value = true;
        else if (status == AnimationStatus.dismissed)
          widget.panelVisible.value = false;
      });
    }
  }

  void _subscribeToValueNotifier() {
    if (widget.panelVisible.value != _backdropPanelVisible)
      _toggleBackdropPanelVisibility();
  }

  /// Required for resubscribing when hot reload occurs
  @override
  void didUpdateWidget(Backdrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.panelVisible?.removeListener(_subscribeToValueNotifier);
    widget.panelVisible?.addListener(_subscribeToValueNotifier);
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.panelVisible?.dispose();
    super.dispose();
  }

  bool get _backdropPanelVisible =>
      _controller.status == AnimationStatus.completed ||
      _controller.status == AnimationStatus.forward;

  void _toggleBackdropPanelVisibility() => _controller.fling(
      velocity: _backdropPanelVisible ? -_kFlingVelocity : _kFlingVelocity);

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_controller.isAnimating)
      _controller.value -= details.primaryDelta / _backdropHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(_kFlingVelocity, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-_kFlingVelocity, -flingVelocity));
    else
      _controller.fling(
          velocity:
              _controller.value < 0.5 ? -_kFlingVelocity : _kFlingVelocity);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final panelSize = constraints.biggest;
      final closedPercentage = widget.frontHeaderVisibleClosed
          ? (panelSize.height - widget.frontHeaderHeight) / panelSize.height
          : 1.0;
      final openPercentage = widget.frontPanelOpenHeight / panelSize.height * 0.2;

      final panelDetailsPosition = Tween<Offset>(
        begin: Offset(0.0, closedPercentage),
        end: Offset(0.0, openPercentage),
      ).animate(_controller.view);

      return Container(
        key: _backdropKey,
        child: Stack(
          children: <Widget>[
            widget.backLayer,
            SlideTransition(
              position: panelDetailsPosition,
              child: _BackdropPanel(
                ter :transformationAnim,
                onTap: _toggleBackdropPanelVisibility,
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                title: widget.frontHeader,
                titleHeight: widget.frontHeaderHeight,
                child: widget.frontLayer,
                padding: widget.frontPanelPadding,
              ),
            ),
          ],
        ),
      );
    });
  }
}
