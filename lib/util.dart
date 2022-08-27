import 'package:translator/translator.dart';

class AppUtils {

  static Future<Translation> translateToBR(String originalText) {
    return GoogleTranslator().translate(originalText, from: 'en', to: 'pt');
  }
}