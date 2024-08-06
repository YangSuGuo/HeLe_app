import 'dart:math' as math;
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/material.dart';

typedef FractionalBuilder = Widget Function(double t);

class ExtendedFlexibleSpace extends StatefulWidget {
  const ExtendedFlexibleSpace({
    super.key,
    this.title,
    this.subtitle,
    this.iconBuilder,
    this.background,
    this.centerTitle,
    this.titlePadding,
    this.collapseMode = CollapseMode.parallax,
    this.stretchModes = const <StretchMode>[StretchMode.zoomBackground],
    this.expandedTitleScale = 1.5,
  })  : assert(collapseMode != null),
        assert(expandedTitleScale >= 1);

  final Widget? title;
  final Widget? subtitle;
  final FractionalBuilder? iconBuilder;
  final Widget? background;
  final bool? centerTitle;
  final CollapseMode collapseMode;
  final List<StretchMode> stretchModes;
  final EdgeInsetsGeometry? titlePadding;
  final double expandedTitleScale;

  @override
  State<ExtendedFlexibleSpace> createState() => _ExtendedFlexibleSpaceState();
}

class _ExtendedFlexibleSpaceState extends State<ExtendedFlexibleSpace> {
  bool _getEffectiveCenterTitle(ThemeData theme) {
    return widget.centerTitle ??
        switch (theme.platform) {
          TargetPlatform.android ||
          TargetPlatform.fuchsia ||
          TargetPlatform.linux ||
          TargetPlatform.windows =>
            false,
          TargetPlatform.iOS || TargetPlatform.macOS => true,
        };
  }

  Alignment _getTitleAlignment(bool effectiveCenterTitle) {
    if (effectiveCenterTitle) {
      return Alignment.bottomCenter;
    }
    return switch (Directionality.of(context)) {
      TextDirection.rtl => Alignment.bottomRight,
      TextDirection.ltr => Alignment.bottomLeft,
    };
  }

  double _getCollapsePadding(double t, FlexibleSpaceBarSettings settings) {
    switch (widget.collapseMode) {
      case CollapseMode.pin:
        return -(settings.maxExtent - settings.currentExtent);
      case CollapseMode.none:
        return 0.0;
      case CollapseMode.parallax:
        final double deltaExtent = settings.maxExtent - settings.minExtent;
        return -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final FlexibleSpaceBarSettings settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
        assert(
          settings != null,
          'A FlexibleSpaceBar must be wrapped in the widget returned by FlexibleSpaceBar.createSettings().',
        );
        final List<Widget> children = <Widget>[];
        final double deltaExtent = settings.maxExtent - settings.minExtent;
        final double t = clampDouble(
            1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent,
            0.0,
            1.0);
        // background
        if (widget.background != null) {
          final double fadeStart =
              math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
          const double fadeEnd = 1.0;
          assert(fadeStart <= fadeEnd);

          final double opacity = settings.maxExtent == settings.minExtent
              ? 1.0
              : 1.0 - Interval(fadeStart, fadeEnd).transform(t);

          double height = settings.maxExtent;

          // StretchMode.zoomBackground
          if (widget.stretchModes.contains(StretchMode.zoomBackground) &&
              constraints.maxHeight > height) {
            height = constraints.maxHeight;
          }
          children.add(Positioned(
            top: _getCollapsePadding(t, settings),
            left: 0.0,
            right: 0.0,
            height: height,
            child: Opacity(
              alwaysIncludeSemantics: true,
              opacity: opacity,
              child: widget.background,
            ),
          ));

          // StretchMode.blurBackground
          if (widget.stretchModes.contains(StretchMode.blurBackground) &&
              constraints.maxHeight > settings.maxExtent) {
            final double blurAmount =
                (constraints.maxHeight - settings.maxExtent) / 10;
            children.add(Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: blurAmount,
                  sigmaY: blurAmount,
                ),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ));
          }
        }

        // title
        if (widget.title != null) {
          final ThemeData theme = Theme.of(context);

          Widget? title;
          switch (theme.platform) {
            case TargetPlatform.iOS:
            case TargetPlatform.macOS:
              title = widget.title;
              break;
            case TargetPlatform.android:
            case TargetPlatform.fuchsia:
            case TargetPlatform.linux:
            case TargetPlatform.windows:
              title = Semantics(
                namesRoute: true,
                child: widget.title,
              );
              break;
          }

          // StretchMode.fadeTitle
          if (widget.stretchModes.contains(StretchMode.fadeTitle) &&
              constraints.maxHeight > settings.maxExtent) {
            final double stretchOpacity = 1 -
                clampDouble((constraints.maxHeight - settings.maxExtent) / 100,
                    0.0, 1.0);
            title = Opacity(
              opacity: stretchOpacity,
              child: title,
            );
          }

          final double opacity = settings.toolbarOpacity;
          if (opacity > 0.0) {
            TextStyle titleStyle = theme.useMaterial3
                ? theme.textTheme.titleLarge!
                : theme.primaryTextTheme.titleLarge!;
            titleStyle = titleStyle.copyWith(
              color: titleStyle.color!.withOpacity(opacity),
            );
            final bool effectiveCenterTitle = _getEffectiveCenterTitle(theme);
            final double leadingPadding =
                (settings.hasLeading ?? true) ? 72.0 : 0.0;
            final EdgeInsetsGeometry padding = widget.titlePadding ??
                EdgeInsetsDirectional.only(
                  start: effectiveCenterTitle ? 0.0 : leadingPadding,
                  bottom: 16.0,
                );
            final double scaleValue =
                Tween<double>(begin: widget.expandedTitleScale, end: 1.0)
                    .transform(t);
            final Matrix4 scaleTransform = Matrix4.identity()
              ..scale(scaleValue, scaleValue, 1.0);
            final Alignment titleAlignment =
                _getTitleAlignment(effectiveCenterTitle);
            final Matrix4 translateTransform = Matrix4.identity()
              ..scale(scaleValue, scaleValue, 1.0);
            final double subtitleFadeProgress = 1 - t > 0.2 ? 1.0 : 0.0;
            double easeIn = pow(t, 3).toDouble();
            children.add(
              Container(
                padding: padding,
                decoration: BoxDecoration(
                  color:
                      theme.colorScheme.surfaceContainerLow.withOpacity(easeIn),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform(
                        alignment: titleAlignment,
                        transform: scaleTransform,
                        child: Align(
                            alignment: titleAlignment,
                            child: DefaultTextStyle(
                                style: titleStyle,
                                child: LayoutBuilder(builder:
                                    (BuildContext context,
                                        BoxConstraints constraints) {
                                  return Container(
                                      width: constraints.maxWidth / scaleValue,
                                      alignment: titleAlignment,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // spacing: constraints.maxWidth / scaleValue - 120,
                                        children: [
                                          title!,
                                          if (widget.iconBuilder != null)
                                            widget.iconBuilder!(t)
                                        ],
                                      ));
                                })))),
                    if (t < 0.8 && widget.subtitle != null)
                      // todo 动画
                      AnimatedOpacity(
                          duration:
                              const Duration(milliseconds: 500), // 淡入淡出持续时间
                          opacity: subtitleFadeProgress,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Transform(
                                  alignment: titleAlignment,
                                  transform: translateTransform,
                                  child: widget.subtitle!)))
                  ],
                ),
              ),
            );
          }
        }

        return ClipRect(child: Stack(children: children));
      },
    );
  }
}
