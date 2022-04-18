import 'package:flutter/material.dart';
import 'widgets.dart';
import 'theme.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'timer.dart';
import 'timer_model.dart';
import 'setting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'Your app name',
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  var myTimer = CountDownTimer();
  void gotoSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingScreen()),
    );
  }

  final double defaultPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<String>> menuItems = [];
    // List menuItems = <PopupMenuItem<String>>[];
    menuItems.add(
      PopupMenuItem<String>(
        value: 'Settings',
        child: Text('Settings'),
      ),
    );
    myTimer.startwork();
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'Settings') {
                gotoSettings(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return menuItems;
            },
          ),
        ],
        title: const Text('My Work Timer'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;
        // We Use LayoutBuilder to get the size of the screen
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    text: 'Work',
                    widthSize: 100.0,
                    color: Color(0xff009688),
                    onPressed: () {
                      myTimer.startwork();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    text: 'Short Break',
                    widthSize: 100.0,
                    color: Color(0xff607D8B),
                    onPressed: () {
                      myTimer.startBreak(true);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    text: 'Long Break',
                    widthSize: 100.0,
                    color: Color(0xff455A64),
                    onPressed: () {
                      myTimer.startBreak(false);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<TimerModel>(
                stream: myTimer.stream(),
                initialData: TimerModel(percent: 0, time: '00:00'),
                builder: (context, snapshot) {
                  var myTimermodel = TimerModel();
                  myTimermodel = (snapshot.data!.time == '00:00')
                      ? TimerModel(percent: 1, time: '00:00')
                      : snapshot.data!;
                  if (snapshot.hasData) {
                    return CircularPercentIndicator(
                      animateFromLastPercent: true,
                      radius: width / 2.5,
                      lineWidth: 5.0,
                      animation: true,
                      percent: myTimermodel.percent!,
                      center: Text(
                        myTimermodel.time!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      progressColor: Colors.red,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    text: 'Stop',
                    widthSize: 100.0,
                    color: Color(0xff212121),
                    onPressed: () {
                      myTimer.stopTimer();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    text: 'Start',
                    widthSize: 100.0,
                    color: Color(0xff009688),
                    onPressed: () {
                      myTimer.startTimer();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
