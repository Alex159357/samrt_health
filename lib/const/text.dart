

import 'package:samrt_health/models/translation_model.dart';

class TextList{
  List<String> langCodes = ["ar", "arc", "dv", "fa", "ha", "he", "khw", "ks", "ku", "ps", "ur", "yi"];

  List<TranslationModel> translationList = [
    TranslationModel(id: "emailErrorText", text: "invalid email address"),
    TranslationModel(id: "passwordErrorText", text:  "password is too short"),
    TranslationModel(id: "emailCaption", text: "e-mail"),
    TranslationModel(id: "passwordCaption", text: "password"),
    TranslationModel(id: "signIn", text: "sign in"),
    TranslationModel(id: "forgot_password", text: "forgot password?"),
    TranslationModel(id: "signUp", text: "sign up"),
    TranslationModel(id: "skip", text: "Skip"),

  ];



}