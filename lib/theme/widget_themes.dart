


import 'package:flutter/material.dart';

class WidgetThemes{

  static   getSliderTheme(BuildContext context){
    return SliderTheme.of(context).copyWith(
      trackHeight: 10.0,
      trackShape: RoundedRectSliderTrackShape(),
      activeTrackColor: Theme.of(context).primaryColor,
      inactiveTrackColor: Theme.of(context).primaryColor.withOpacity(0.2),
      thumbShape: RoundSliderThumbShape(
        enabledThumbRadius: 14.0,
        pressedElevation: 8.0,
      ),
      thumbColor: Theme.of(context).colorScheme.secondary,
      overlayColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
      tickMarkShape: RoundSliderTickMarkShape(),
      activeTickMarkColor: Theme.of(context).colorScheme.secondary,
      inactiveTickMarkColor: Theme.of(context).backgroundColor,
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      valueIndicatorColor: Colors.black,
      valueIndicatorTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    );
  }

  static Shader linearGradient(BuildContext context) => LinearGradient(
    colors: <Color>[Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
  ).createShader(
    Rect.fromLTWH(0.0, 0.0, 150.0, 70.0),
  );


  static String percentageModifier(double value, String s) {
    final roundedValue = value.ceil().toInt().toString();
    return '$roundedValue $s';
  }


}