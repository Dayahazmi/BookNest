import 'package:get/get.dart';

class Capturetext extends GetxController {
  var recognizedText = ''.obs;

  void updateRecognixedText(String text) {
    recognizedText.value = text;
  }
}
