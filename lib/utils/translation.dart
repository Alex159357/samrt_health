
import 'package:flutter/material.dart';
import 'package:samrt_health/models/translation_model.dart';
import 'package:samrt_health/services/translate_api.dart';



class Translation{
  Future<String> getTranslatedString(String text) async {
    return TranslateApi.translate2(text);
  }

  Widget getTranslatedText({required String text, TextStyle? style}) {
    return FutureBuilder(
      future: TranslateApi.translate2(text),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return Text(snapshot.data!, style: style);
        }
        return Text(text, style: style);
      },
    );
  }

}
