import 'package:fisher/global_settings.dart';
import 'package:fisher/page/welcome_page.dart';
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
      home: const WelcomePage(),
    );
  }
}
