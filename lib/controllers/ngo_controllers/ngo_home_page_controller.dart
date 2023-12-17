import 'package:get/get.dart';

class NGOHomePageController extends GetxController {
  //
  var currentIndex = 0.obs;

  //
  void onBottomOptionTap(int newIndex) {
    currentIndex.value = newIndex;
  }
}