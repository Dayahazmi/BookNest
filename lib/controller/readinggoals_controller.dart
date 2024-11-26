import 'package:get/get.dart';

class ReadinggoalsController extends GetxController {
  var readingDays = List<bool>.filled(7, false).obs;
  var readingHours = ''.obs;
  var totalBooksRead = ''.obs;
  var currentGenres = ''.obs;
  var bookPercentage = ''.obs;
  var name = ''.obs;

  void toggleReadingDays(int index) {
    readingDays[index] = !readingDays[index];
  }
}
