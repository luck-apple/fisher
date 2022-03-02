import 'package:flutter/material.dart';

Route<T> routeBuilder<T>({required Widget target}) {
  return MaterialPageRoute(builder: ((context) => target));
}

Route<T> routeBuilderWithArg<T>({
  required Widget target,
  required Object args,
}) {
  return MaterialPageRoute(
    builder: (context) => target,
    settings: RouteSettings(arguments: args),
  );
}
