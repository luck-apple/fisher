import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences _globalSettings;

Future<void> initGlobalSettings() async {
  _globalSettings = await SharedPreferences.getInstance();
}

/// 保存摸鱼时长
void setFishDuration(int minutes) {
  _globalSettings.setInt('fish_duration', minutes);
}

/// 获取摸鱼时长，默认10分钟
int getFishDuration() {
  return _globalSettings.getInt('fish_duration') ?? 10;
}
