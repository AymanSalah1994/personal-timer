import 'dart:async';
import 'timer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer {
  late int work;
  late int shortBreak;
  late int longBreak;
  double _radius = 1;
  bool _isActive = true;
  Timer? timer;
  Duration? _time;
  // Remaining time
  Duration? _fullTime;

  void startTimer() {
    if (_time!.inSeconds > 0) {
      this._isActive = true;
    }
  }

  void stopTimer() {
    this._isActive = false;
  }

  String returnTime(Duration t) {
    // Takes the Time and Transforms it into a String
    // And then returns it to be Shown as a Text
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int timeSeconds = t.inSeconds - (t.inMinutes * 60);
    //  This Will return ommited secodns
    String seconds = (timeSeconds < 10)
        ? '0' + timeSeconds.toString()
        : timeSeconds.toString();
    return minutes + ':' + seconds;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;
      if (this._isActive) {
        _time = _time! - Duration(seconds: 1);
        _radius = _time!.inSeconds / _fullTime!.inSeconds;
        if (_time!.inSeconds <= 0) {
          _isActive = false;
        }
      }
      time = returnTime(_time!);
      return TimerModel(percent: _radius, time: time);
    });
  }

  void startwork() async {
    // This is Working like a Constructor for the timer  ;
    // For a Fresh timer ;
    await readtheSettings();
    _radius = 1;
    _time = Duration(minutes: work, seconds: 0);
    _fullTime = _time;
  }

  void startBreak(bool isShort) async {
    // This is Working like a Constructor for the timer  ;
    // For a Fresh timer ;
    // short break here is 5 minutes
    await readtheSettings();
    _radius = 1;
    _time = (isShort)
        ? Duration(minutes: shortBreak, seconds: 0)
        : Duration(minutes: longBreak, seconds: 0);
    _fullTime = _time;
  }

  Future readtheSettings() async {
    var prefs = await SharedPreferences.getInstance();
    work = 25;
    shortBreak = 5;
    longBreak = 15;
    if (prefs.getInt('workTime') == null) {
      prefs.setInt('workTime', 25);
    } else {
      work = await prefs.getInt('workTime')!;
    }
    if (prefs.getInt('shortBreak') == null) {
      prefs.setInt('shortBreak', 5);
    } else {
      shortBreak = await prefs.getInt('shortBreak')!;
    }
    if (prefs.getInt('longBreak') == null) {
      prefs.setInt('longBreak', 15);
    } else {
      longBreak = await prefs.getInt('longBreak')!;
    }
  }
}
