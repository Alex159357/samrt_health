import 'package:samrt_health/const/text.dart';
import 'package:samrt_health/models/translation_model.dart';
import 'package:samrt_health/services/translate_api.dart';



class Translation extends TextList{
  String getTranslate(String id) {
    var translateObj =
        translationList.where((element) => element.id == id.toString()).first;
    return translateObj.text;
  }

  Future<void> instance() async {
    String toTranslate = "";
    for (var element in translationList) {
      toTranslate += element.text + "/";
    }
    String result = await TranslateApi.translate2(toTranslate);
    var resultList = result.split("/");
    for (int i = 0; i < resultList.length; i++) {
      var element = resultList[i];
      if (i < resultList.length - 1) {
        var id = translationList[i].id;
        translationList[i] = TranslationModel(id: id, text: element);
      }
    }
    return;
  }

}
