import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final String text;
  final double widthSize;
  final Color color;
  final VoidCallback onPressed;
  ProductivityButton({
    required this.text,
    required this.widthSize,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        '${this.text}',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: this.onPressed,
      color: this.color,
      minWidth: this.widthSize,
    );
  }
}

typedef CallBackSetting = void Function(String key, int value);

class SettingButton extends StatelessWidget {
  final String text;
  final Color color;

  final String itemKey;
  final int value;
  final CallBackSetting callBackSetting;
  SettingButton(
    this.color,
    this.text,
    this.itemKey,
    this.value,
    this.callBackSetting,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => this.callBackSetting(this.itemKey, this.value),
      // this.callBackSetting(this.itemKey, this.value) << This Alone NOT working ?
      child: Text(
        this.text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: this.color,
    );
  }
}
