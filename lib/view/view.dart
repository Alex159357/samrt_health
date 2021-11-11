import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samrt_health/const/text.dart';
import 'package:samrt_health/services/translate_api.dart';
import 'package:samrt_health/view/loading_view.dart';

import '../main.dart';
import 'logo_view.dart';

class View {
  final LoadingView _loadingView = LoadingView();
  LogoView _logoView = LogoView();

  LoadingView get loadingView => _loadingView;

  LogoView get logoView => _logoView;

  Widget getTranslatedText({required String text, TextStyle? style}) {
    return FutureBuilder(
      future: TranslateApi.translate2(text),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
          return Text(snapshot.data!,
              textDirection: TextList().langCodes.contains(locale)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              style: style);
        }
        return Text(text, style: style);
      },
    );
  }

  Future<String> getTranslatedString(String text) async {
    return TranslateApi.translate2(text);
  }
}
