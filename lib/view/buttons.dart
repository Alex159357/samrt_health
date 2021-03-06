import 'package:flutter/material.dart';
import 'package:samrt_health/view/view.dart';

class Buttons {
  static Widget mainButton({required Function onPressed, required String text, Color? background, Color? borderColor, Color? textColor}) =>
     ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(background?? Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(color: borderColor ?? Colors.white)))),
        onPressed: () => onPressed(),
        child:  View().getTranslatedText(text: text, style: TextStyle(color: textColor?? Colors.white)));


}
