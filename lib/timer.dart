import 'dart:async';
import 'timer_model.dart';

class CountDownTimer {
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
    String  minutes = (t.inMinutes < 10) ? '0' + t.inMinutes.toString() : t.inMinutes.toString();
    int timeSeconds = t.inSeconds - (t.inMinutes * 60);
    //  This Will return ommited secodns 
    String seconds = (timeSeconds < 10) ? '0' + timeSeconds.toString() : timeSeconds.toString();
    return minutes + ':' + seconds;
  }
}
