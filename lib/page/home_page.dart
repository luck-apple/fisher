import 'dart:io';
import 'package:fisher/model/fish_os.dart';
import 'package:fisher/page/fish_macos.dart';
import 'package:fisher/util/route_utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FishOS _fishOS = Platform.isMacOS ? FishOS.macos : FishOS.windows;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b202d),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              '请选择系统:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            _checkableItem(_fishOS == FishOS.macos, "MacOS", (checked) {
              if (checked != null && checked) {
                setState(() {
                  _fishOS = FishOS.macos;
                });
              }
            }),
            const SizedBox(height: 4),
            _checkableItem(_fishOS == FishOS.windows, "Windows", (checked) {
              if (checked != null && checked) {
                setState(() {
                  _fishOS = FishOS.windows;
                });
              }
            }),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text('进入摸鱼状态'),
              ),
              onPressed: _startTouchFish,
            )
          ],
        ),
      ),
    );
  }

  Widget _checkableItem(
      bool isChecked, String title, Function(bool?) onCheckChanged) {
    return GestureDetector(
      onTap: () => onCheckChanged(!isChecked),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          border: isChecked
              ? Border.all(color: Theme.of(context).primaryColor)
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onCheckChanged,
              side: const BorderSide(color: Colors.white70, width: 2),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startTouchFish() {
    if (_fishOS == FishOS.macos) {
      Navigator.push(context, routeBuilder(target: const FishMacOSPage()));
    } else if (_fishOS == FishOS.windows) {
      print('windows');
    }
  }
}
