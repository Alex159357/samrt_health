import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';


import '../main.dart';

class TranslateApi {
  static const String _googleApiKey = "AIzaSyA7V7k6v7YoOzZ5wjW4WFOMbgdQfvkdzow";

  static Future<String> translate(String message) async {

    final response = await http.post(
      Uri.parse('https://translation.googleapis.com/language/translate/v2?target=$locale&key=$_googleApiKey&q=$message')
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final translations = body['data']['translations'] as List;
      final translation = translations.first;

      return HtmlUnescape().convert(translation['translatedText']);
    } else {
      return message;
      throw Exception();
    }
  }

  static Future<String> translate2(
      String message) async {

    final response = await http.post(
        Uri.parse('https://translation.googleapis.com/language/translate/v2?target=$locale&key=$_googleApiKey&q=$message')
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
        to: locale,
      );
      return translation.text;
    }

  }

  static final languages = <String>[
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
    'Russian'
  ];

  static String getLanguageCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
      case 'French':
        return 'fr';
      case 'Italian':
        return 'it';
      case 'Russian':
        return 'ru';
      case 'Spanish':
        return 'es';
      case 'German':
        return 'de';
      default:
        return 'en';
    }
  }
}
