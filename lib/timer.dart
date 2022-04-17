import 'dart:async';
import 'timer_model.dart';

class CountDownTimer {
  int work = 30;
  double _radius = 1;
  bool _isActive = true;
  Timer? timer;
  Duration? _time;
  // Remaining time
  Duration? _fullTime;

  String returnTime(Duration t) {
    // Takes the Time and Transforms it into a String
    // And then returns it to be Shown as a Text
    //
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

// Object . stream ,, you List to it When there is a New Data  ;

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

  void startwork() {
    _radius = 1;
    _time = Duration(minutes: work, seconds: 0);
    _fullTime = _time;
  }
}
