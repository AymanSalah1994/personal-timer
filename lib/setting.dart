import 'dart:ui';

import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Center(
        child: Setting(),
      ),
    );
  }
}

// Here is the Statefull widget ;

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late TextEditingController txtwork;
  late TextEditingController txtlong;
  late TextEditingController txtshort;

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int? workTime;
  int? shortBreak;
  int? longBreak;

  late SharedPreferences pref;

  void updateSettings(String key, int value) {
    // pref.setInt(key, value);
    switch (key) {
      case WORKTIME:
        int? oldVal = pref.getInt(WORKTIME);
        if (oldVal! <= 180 && oldVal! >= 1) {
          oldVal += value;
          pref.setInt(WORKTIME, oldVal);
          setState(() {
            txtwork.text = oldVal.toString();
          });
        }
        break;
      case SHORTBREAK:
        int? oldVal = pref.getInt(SHORTBREAK);
        if (oldVal! <= 180 && oldVal! >= 1) {
          oldVal += value;
          pref.setInt(SHORTBREAK, oldVal);
          setState(() {
            txtshort.text = oldVal.toString();
          });
        }
        break;
      case LONGBREAK:
        int? oldVal = pref.getInt(LONGBREAK);
        if (oldVal! <= 180 && oldVal! >= 1) {
          oldVal += value;
          pref.setInt(LONGBREAK, oldVal);
          setState(() {
            txtlong.text = oldVal.toString();
          });
        }
        break;
    }
  }

  Future readsetting() async {
    pref = await SharedPreferences.getInstance();
    workTime = pref.getInt(WORKTIME);
    if (workTime == null) {
      workTime = 25;
      await pref.setInt(WORKTIME, int.parse('25'));
    }
    shortBreak = pref.getInt(SHORTBREAK);
    if (shortBreak == null) {
      shortBreak = 5;
      await pref.setInt(SHORTBREAK, int.parse('5'));
    }
    longBreak = pref.getInt(LONGBREAK);
    if (longBreak == null) {
      longBreak = 15;
      await pref.setInt(LONGBREAK, int.parse('15'));
    }
    setState(() {
      txtlong.text = longBreak.toString();
      txtshort.text = shortBreak.toString();
      txtwork.text = workTime.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    txtwork = TextEditingController();
    txtlong = TextEditingController();
    txtshort = TextEditingController();
    readsetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24);
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3,
        children: [
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingButton(Color(0xff455A64), "-", WORKTIME, -1, updateSettings),
          TextField(
              controller: txtwork,
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingButton(Color(0xff009688), "+", WORKTIME, 1, updateSettings),
          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingButton(Color(0xff455A64), "-", SHORTBREAK, -1, updateSettings),
          TextField(
              controller: txtshort,
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingButton(Color(0xff009688), "+", SHORTBREAK, 1, updateSettings),
          Text(
            "Long",
            style: textStyle,
          ),
          Text(""),
          Text(""),
          SettingButton(Color(0xff455A64), "-", LONGBREAK, -1, updateSettings),
          TextField(
              controller: txtlong,
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingButton(Color(0xff009688), "+", LONGBREAK, 1, updateSettings),
        ],
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}
