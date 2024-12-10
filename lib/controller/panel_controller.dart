import 'package:get/get.dart';

class PanelController extends GetxController {
  final RxList<bool> expanded = [false, false, false, false, false].obs;

  void togglePanel(int index) {
    expanded[index] = !expanded[index];
  }
}
