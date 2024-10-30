import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/features/onboarding/bindings/onboarding_binding.dart';
import 'package:pgnpartner_mobile/features/onboarding/views/onboarding_view.dart';

class AppWidget extends StatelessWidget {
  final String initialRoute;
  const AppWidget({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "PGN Partner",
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: false,
      ),
      getPages: AppPages.routes,
      initialRoute: Routes.onboarding,
      home: OnboardingView(),
      initialBinding: OnboardingBinding(),
      locale: const Locale('id', 'ID'),
    );
  }
}
