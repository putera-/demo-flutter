import 'package:get/get.dart';

class BottomSheetListCheckBoxController<T> extends GetxController {
  var selectedItems = <T>{}.obs; // Observable set of selected items

  void toggleItem(T item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }

  bool isSelected(T item) {
    return selectedItems.contains(item);
  }
}
