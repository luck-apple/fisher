import 'dart:io';

import 'package:desktop_window/desktop_window.dart';

class DeviceWrapper {
  static final bool isMobile = Platform.isAndroid || Platform.isIOS;

  static final bool isDesktop =
      Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  // desktop_window support platform: Linux, MacOS, Windows
  static void setFullScreen(bool fullscreen, {void Function()? block}) async {
    if (isDesktop) {
      DesktopWindow.setFullScreen(fullscreen).then((value) {
        block?.call();
      });
    } else {
      block?.call();
    }
  }
}
