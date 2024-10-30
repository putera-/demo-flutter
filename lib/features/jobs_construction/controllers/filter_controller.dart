import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/bottom_sheets/list_check_box/bottom_sheet_list_checkbox_controller.dart';
import 'package:pgnpartner_mobile/data/models/location/location_model.dart';
import 'package:pgnpartner_mobile/services/auth_service.dart';

class FilterController extends GetxController {
  var searchText = '';

  // auth service
  final authService = AuthService();

  // SORT
  final BottomSheetListCheckBoxController<String> sortOptionController = BottomSheetListCheckBoxController<String>();
  final Rx<bool> isSorted = false.obs;
  final List<String> sortOptions = [
    'Terbaru',
    'Terdekat dari Tanggal Hari ini',
    'Terdekat dari Lokasi Anda',
  ];

  void removeSortItem(String item) {
    sortOptionController.selectedItems.remove(item);
    if (sortOptionController.selectedItems.isEmpty) {
      isSorted.value = false;
    }
  }

  void resetSort() {
    isSorted.value = false;
    sortOptionController.selectedItems.clear();
  }

  // JENIS
  final BottomSheetListCheckBoxController<String> jobTypeController = BottomSheetListCheckBoxController<String>();
  final Rx<bool> isSelectedJobtype = false.obs;

  final List<String> jobTypeOptions = [
    'Pipa Instalasi (SK)',
    'Pipa Service (SR)',
    'Pasang Gas Meter',
    'Gas In',
  ];

  void removeJobTypeItem(String item) {
    jobTypeController.selectedItems.remove(item);
    if (jobTypeController.selectedItems.isEmpty) {
      isSelectedJobtype.value = false;
    }
  }

  void resetJobType() {
    isSelectedJobtype.value = false;
    jobTypeController.selectedItems.clear();
  }

  // FILTER AREA
  void resetFilterArea() {
    kabupatenOptions.clear();

    getKabupatens();
  }

  // KABUPATEN
  final RxMap<String, BottomSheetListCheckBoxController<String>> kabupatenControllers =
      <String, BottomSheetListCheckBoxController<String>>{}.obs;

  // KECAMATAN
  final RxMap<String, BottomSheetListCheckBoxController<String>> kecamatanControllers =
      <String, BottomSheetListCheckBoxController<String>>{}.obs;

  final RxMap<String, BottomSheetListCheckBoxController<String>> kelurahanControllers =
      <String, BottomSheetListCheckBoxController<String>>{}.obs;

  final RxSet<String> selectedAreas = <String>{}.obs;

  final RxList<KabupatenModel> kabupatenOptions = <KabupatenModel>[].obs;
  final RxSet<KabupatenModel> selectedKabupatens = <KabupatenModel>{}.obs;

  Future<void> getKabupatens() async {
    List<KabupatenModel> kabupatens = await authService.getKabupatens();

    for (KabupatenModel p in kabupatens) {
      kabupatenControllers[p.code] = BottomSheetListCheckBoxController<String>();
    }

    kabupatenOptions.addAll(kabupatens);
  }

  bool isKabupatenSelected(String code) {
    print("test");
    return selectedKabupatens.any((kabupaten) => kabupaten.code == code);
  }

  void toggleKabupatenSelection(KabupatenModel kabupaten) {
    if (selectedKabupatens.any((p) => p.code == kabupaten.code)) {
      selectedKabupatens.removeWhere((p) => p.code == kabupaten.code);

      kabupatenControllers[kabupaten.code]?.selectedItems.clear();
    } else {
      selectedKabupatens.add(kabupaten);
    }
  }

  void resetSortArea(String code) {
    kabupatenControllers[code]?.selectedItems.clear();
    kecamatanControllers[code]?.selectedItems.clear();
    kelurahanControllers[code]?.selectedItems.clear();
  }

  void removeAreaItem(String code, String kelurahan) {
    kabupatenControllers[code]?.selectedItems.remove(kelurahan);
    kecamatanControllers[code]?.selectedItems.remove(kelurahan);
  }

  // RESET ALL

  void resetAll() {
    resetSort();
    resetJobType();
    selectedKabupatens.clear();
  }
}
