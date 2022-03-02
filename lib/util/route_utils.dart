import 'package:flutter/material.dart';

Route<T> routeBuilder<T>(Widget target, {Object? args}) {
  if (args == null) {
    return MaterialPageRoute(builder: ((context) => target));
  } else {
    return MaterialPageRoute(
      builder: (context) => target,
      settings: RouteSettings(arguments: args),
    );
  }
}
