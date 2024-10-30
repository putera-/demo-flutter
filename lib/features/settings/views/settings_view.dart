import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/utils/color_extensions.dart';
import 'package:pgnpartner_mobile/features/settings/controllers/create_settings_controller.dart';

class SettingsView extends GetView<CreateSettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(
            color: AppTheme.border300,
            width: 1,
          ),
        ),
        backgroundColor: AppTheme.primary,
        title: Text(
          'Pengaturan Akun',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: HexColor('#F3F6FC'),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengaturan Akun',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: HexColor('#1D2939'),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.border300, width: 1),
                    color: Colors.white,
                    boxShadow: const [AppTheme.boxShadow300],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildListTile(
                        icon: 'assets/icons/ic_user.svg',
                        title: 'Akun Saya',
                        subtitle: 'Informasi tentang email, password, dan nomor HP',
                      ),
                      const Divider(),
                      _buildListTile(
                        icon: 'assets/icons/ic_bell.svg',
                        title: 'Notifikasi',
                        onTap: () => Get.toNamed(Routes.notification),
                      ),
                      Obx(() => controller.isBiometricAvailable.value ? const Divider() : const SizedBox.shrink()),
                      Obx(
                        () => controller.isBiometricAvailable.value
                            ? _buildListTile(
                                icon: 'assets/icons/ic_fingerprint.svg',
                                title: 'Login Biometrik',
                                trailing: CupertinoSwitch(
                                  activeColor: AppTheme.primary,
                                  value: controller.isBiometricEnabled.value,
                                  onChanged: (value) => controller.toggleBiometric(value, context),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Infromasi PGN Partner',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: HexColor('#1D2939'),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.border300, width: 1),
                    color: Colors.white,
                    boxShadow: const [AppTheme.boxShadow300],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildListTile(
                        icon: 'assets/icons/ic_notepad_setting.svg',
                        title: 'Syarat dan Ketentuan',
                      ),
                      const Divider(),
                      _buildListTile(
                        icon: 'assets/icons/ic_security_setting.svg',
                        title: 'Kebijakan Privasi',
                      ),
                      const Divider(),
                      _buildListTile(
                        icon: 'assets/icons/ic_star_setting.svg',
                        title: 'Ulas Aplikasi',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () => controller.onLogout(context),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.border300, width: 1),
                      color: Colors.white,
                      boxShadow: const [AppTheme.boxShadow300],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildListTile(
                          icon: 'assets/icons/ic_sign_out_setting.svg',
                          title: 'Keluar',
                          isLogout: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: isLogout ? HexColor('#E6333C') : HexColor('#1D2939'),
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: HexColor('#475467'),
                ),
              )
            : null,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
