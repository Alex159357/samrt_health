import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';


import '../main.dart';

class TranslateApi {
  static const String _googleApiKey = "AIzaSyD6kN7wNB7bpO_TQrG8KfErwYbi2H8xmNA";

  // static Future<String> translate(String message) async {
  //
  //   final response = await http.post(
  //     Uri.parse('https://translation.googleapis.com/language/translate/v2?target=$locale&key=$_googleApiKey&q=$message')
  //   );
  //
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body);
  //     final translations = body['data']['translations'] as List;
  //     final translation = translations.first;
  //
  //     return HtmlUnescape().convert(translation['translatedText']);
  //   } else {
  //     return message;
  //     throw Exception();
  //   }
  // }

  static Future<String> translate2(
      String message) async {
    var lang = locale.split("_")[0];
    final response = await http.post(
        Uri.parse('https://translation.googleapis.com/language/translate/v2?target=$lang&key=$_googleApiKey&q=$message')
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final translations = body['data']['translations'] as List;
      final translation = translations.first;

      return HtmlUnescape().convert(translation['translatedText']);
    } else {
      final translation = await GoogleTranslator().translate(
        message,
        from: "en",
        to: lang,
      );
      return translation.text;
    }

  }

}
