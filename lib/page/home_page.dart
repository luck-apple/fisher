import 'dart:io';
import 'package:fisher/global_settings.dart';
import 'package:fisher/model/fish_os.dart';
import 'package:fisher/page/fish_macos.dart';
import 'package:fisher/page/fish_windows.dart';
import 'package:fisher/util/route_utils.dart';
import 'package:fisher/util/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FishOS _fishOS = Platform.isMacOS ? FishOS.macos : FishOS.windows;
  final TextEditingController _durationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _durationController.text = getFishDuration().toString();
  }

  @override
  void dispose() {
    _durationController.dispose();
    super.dispose();
  }

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
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 12),
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
            const SizedBox(height: 20),
            const Text(
              '请设置时长:',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 12),
            _fishConfigDuraion(),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text('开始摸鱼'),
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
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fishConfigDuraion() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 70,
          height: 34,
          child: TextField(
            controller: _durationController,
            style: const TextStyle(
              color: Colors.white,
              height: 1.4,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(2),
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {},
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, bottom: 2),
          child: const Text(
            '分钟',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }

  void _startTouchFish() {
    if (_durationController.text.isEmpty) {
      Toaster.show('请输入摸鱼时长', context, gravity: Toaster.center);
      return;
    }

    int minutes = int.parse(_durationController.text);
    if (minutes < 1) {
      Toaster.show('摸鱼时长最低1分钟', context, gravity: Toaster.center);
      return;
    }

    if (_fishOS == FishOS.macos) {
      Navigator.push(context, routeBuilder(const FishMacOSPage()));
    } else if (_fishOS == FishOS.windows) {
      Navigator.push(context, routeBuilder(const FishWindowsPage()));
    }
    setFishDuration(minutes);
  }
}
