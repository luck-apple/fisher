import 'package:fisher/global_settings.dart';
import 'package:fisher/util/device_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FishWindowsPage extends StatefulWidget {
  const FishWindowsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FishWindowsPageState();
}

class _FishWindowsPageState extends State<FishWindowsPage>
    with SingleTickerProviderStateMixin {
  final _textStyle = const TextStyle(color: Colors.white, fontSize: 22);

  late final AnimationController _controller = AnimationController(
    duration: Duration(minutes: getFishDuration()),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
    DeviceWrapper.setFullScreen(true, block: () => _startAnimation());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onFishTouchEnd();
      }
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3275D0),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onDoubleTap: _onFishTouchEnd,
              child: Lottie.asset(
                'assets/lotties/windows_progress.json',
                width: 130,
                height: 130,
              ),
            ),
            const SizedBox(height: 30),
            Text('正在配置 Windows 更新', style: _textStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('已完成 ', style: _textStyle),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return Text(
                      (_controller.value * 100).toInt().toString(),
                      style: _textStyle,
                    );
                  },
                ),
                Text('%', style: _textStyle),
              ],
            ),
            Text('请勿关闭计算机', style: _textStyle),
          ],
        ),
      ),
    );
  }

  void _onFishTouchEnd() {
    DeviceWrapper.setFullScreen(false, block: () => Navigator.pop(context));
  }
}
