import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppEnvironment {
  AppEnvironment._();

  static final brightness = SchedulerBinding.instance.window.platformBrightness;

  static final rootNavigationKey = GlobalKey<NavigatorState>();

  static final ValueNotifier<Object?> deepLinkArgs = ValueNotifier(null);

  static NavigatorState get navigator => rootNavigationKey.currentState!;

  static final swipeWidth = ValueNotifier<double>(0.7);

  static final routeObserver = RouteObserver<ModalRoute>();
}
