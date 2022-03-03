import 'package:fisher/global_settings.dart';
import 'package:fisher/page/welcome_page.dart';
import 'package:fisher/util/device_wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FisherApp());
}

class FisherApp extends StatefulWidget {
  const FisherApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FisherApp();
}

class _FisherApp extends State<FisherApp> {
  @override
  void initState() {
    super.initState();
    initGlobalSettings();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fisher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) => Scaffold(
        body: GestureDetector(
          onTap: () {
            _hideKeyboard(context);
          },
          child: child,
        ),
      ),
      home: const WelcomePage(),
    );
  }

  void _hideKeyboard(BuildContext ctx) {
    if (!DeviceWrapper.isMobile) {
      return;
    }
    FocusScopeNode currentFocus = FocusScope.of(ctx);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
