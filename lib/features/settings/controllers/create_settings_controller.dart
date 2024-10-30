import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/dialogs/general_dialog.dart';
import 'package:pgnpartner_mobile/data/repositories/auth_repository.dart';
import 'package:pgnpartner_mobile/services/auth_service.dart';

class CreateSettingsController extends GetxController {
  final isBiometricEnabled = false.obs;
  final isBiometricAvailable = false.obs;
  final _authRepository = AuthRepository();
  final auth = LocalAuthentication();

  final AuthService authService = AuthService();

  @override
  void onReady() {
    onCheckBiometric();
    super.onReady();
  }

  onCheckBiometric() async {
    final availableBiometrics = await auth.getAvailableBiometrics();
    isBiometricAvailable.value = availableBiometrics.isNotEmpty;
    final status = await authService.getBiometricStatus();
    isBiometricEnabled.value = status;
  }

  void toggleBiometric(bool value, BuildContext context) async {
    final status = await authService.getBiometricStatus();

    if (value == true && !status) {
      try {
        final didAuthenticate = await auth.authenticate(localizedReason: 'Please authenticate to show account balance');
        if (didAuthenticate) {
          if (context.mounted) showPopupBiometric(context);
          isBiometricEnabled.value = true;
          authService.activateBiometric();
        } else {
          authService.deActivateBiometric();
        }
      } on PlatformException {
        authService.deActivateBiometric();
        isBiometricEnabled.value = false;
      }
    } else {
      authService.deActivateBiometric();
      isBiometricEnabled.value = false;
    }
  }

  showPopupBiometric(BuildContext context) {
    GeneralDialog.show(
      image: SizedBox(
        width: 55,
        height: 55,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            'assets/icons/ic_check_circle.svg',
          ),
        ),
      ),
      title: 'Anda Berhasil mendaftarkan Biometrik.',
      description:
          'Untuk setiap kegiatan transaksi maupun Login, Anda dapat gunakan Biometrik yang sudah diaftarkan dengan tujuan keamanan dan kecepatan',
      primaryButtonText: "Mengerti",
      onTapPrimary: () {
        Navigator.pop(context);
      },
    );
  }

  onLogout(BuildContext context) async {
    showLoadingPopup(context);
    await _authRepository.logout();
    await authService.removeSessionKey();
    await authService.removeKabupatens();
    await authService.removeUser();
    if (context.mounted) {
      // Navigator.pop(context);
      // final navigationController = Get.find<NavigationController>();
      // navigationController.currentIndex.value = 0;
      AppPages.setInitialRoute(Routes.login);
      Get.offAllNamed(Routes.login);
    }
  }

  void showLoadingPopup(BuildContext context) {
    GeneralDialog.showLoadingDialog(
      title: "Tunggu Sebentar ...",
    );
  }
}
