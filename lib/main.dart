import 'package:flutter/material.dart';
import 'widgets.dart';
import 'theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
  void emptymethod() {}
  final double defaultPadding = 5.0;
  const TimerHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    text: 'Start',
                    widthSize: 100.0,
                    color: Color(0xff009688),
                    onPressed: () {
                      emptymethod();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    text: 'Stop',
                    widthSize: 100.0,
                    color: Color(0xff607D8B),
                    onPressed: () {
                      emptymethod();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    text: 'Stop',
                    widthSize: 100.0,
                    color: Color(0xff455A64),
                    onPressed: () {
                      emptymethod();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            Expanded(
              child: CircularPercentIndicator(
                radius: width / 3,
                lineWidth: 10.0,
                percent: 1,
                progressColor: Color(0xff009688),
                center: Text(
                  '50%',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    text: 'Start',
                    widthSize: 100.0,
                    color: Color(0xff212121),
                    onPressed: () {
                      emptymethod();
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
                      emptymethod();
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
