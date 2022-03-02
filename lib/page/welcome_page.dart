import 'package:fisher/page/home_page.dart';
import 'package:fisher/util/route_utils.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final baseTextStyle = const TextStyle(color: Color(0xffeeeeee), fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b202d),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              '这是一个摸鱼 App',
              style: TextStyle(
                color: Color(0xff92cbea),
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 30),
            Text('其实这是一个玩笑。', style: baseTextStyle),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: '点击 ',
                style: baseTextStyle,
                children: const <TextSpan>[
                  TextSpan(
                      text: '开始',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(text: ' 按钮后应用会显示一个系统升级画面，这时候你就可以休息一下，优雅地喝一杯咖啡。'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text("不要内疚，适当的休息可以让你的大脑重新充满活力，从容面对挑战，更高效的完成工作。",
                style: baseTextStyle),
            const SizedBox(height: 8),
            Text("所以放心大胆地使用摸鱼吧。", style: baseTextStyle),
            const SizedBox(height: 60),
            _startButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _startButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, routeBuilder(target: const HomePage()));
      },
      textColor: Colors.white,
      shape: Border.all(
        color: const Color(0xff48aab4),
        width: 2,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
      child: const Text('开始', style: TextStyle(fontSize: 20)),
    );
  }
}
