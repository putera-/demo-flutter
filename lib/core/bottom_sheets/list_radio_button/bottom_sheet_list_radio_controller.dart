import 'package:get/get.dart';

class BottomSheetListRadioButtonController<T> extends GetxController {
  Rx<T?> selectedItem = Rx<T?>(null); // Observable for a single selected item

  void selectItem(T item) {
    selectedItem.value = item;
  }

  bool isSelected(T item) {
    return selectedItem.value == item;
  }
}
