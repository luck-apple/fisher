import 'package:fisher/global_settings.dart';
import 'package:fisher/util/device_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FishMacOSPage extends StatefulWidget {
  const FishMacOSPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FishMacOSPageState();
}

class _FishMacOSPageState extends State<FishMacOSPage>
    with SingleTickerProviderStateMixin {
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
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onDoubleTap: _onFishTouchEnd,
              child: Image.asset(
                'assets/images/logo_apple.png',
                color: CupertinoColors.white,
                width: 100,
              ),
            ),
            Container(
              width: 200,
              padding: const EdgeInsets.only(top: 45),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.5),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return LinearProgressIndicator(
                      value: _controller.value,
                      backgroundColor:
                          CupertinoColors.lightBackgroundGray.withOpacity(0.3),
                      color: CupertinoColors.white,
                      minHeight: 5,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFishTouchEnd() {
    DeviceWrapper.setFullScreen(false, block: () => Navigator.pop(context));
  }
}
