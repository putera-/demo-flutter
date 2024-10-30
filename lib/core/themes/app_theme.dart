import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFFF9FAFB);
  static const Color primary = Color(0xFF0057B8);
  static const Color lightPrimary = Color(0xFF095383);
  static const Color unselected = Color(0xFF475467);

  static const Color orange700 = Color(0xFFB58215);
  static const Color orange600 = Color(0xFFEA9800);
  static const Color orange500 = Color(0xFFE8A71B);
  static const Color orange100 = Color(0xFFFFF8E9);

  static const Color green800 = Color(0xFF2D8625);
  static const Color green700 = Color(0xFF767900);
  static const Color green500 = Color(0xFF29A11E);
  static const Color green400 = Color(0xFFA8AD00);
  static const Color green300 = Color(0xFFACCE06);
  static const Color green100 = Color(0xFFF7FAE6);
  static const Color green50 = Color(0xFFECF9EB);

  static const Color blue800 = Color(0xFF002C5C);
  static const Color blue600 = Color(0xFF1174CD);
  static const Color blue400 = Color(0xFF35A3E8);
  static const Color blue300 = Color(0xFF3AB3FF);
  static const Color blue200 = Color(0xFFEFF5FD);
  static const Color blue100 = Color(0xFFEBF7FF);
  static const Color blue50 = Color(0xFFE7F1FA);

  static const Color red500 = Color(0xFFE6333C);
  static const Color red100 = Color(0xFFFDEBEC);

  static const Color brown500 = Color(0xFFB37632);

  static const Color secondary900 = Color(0xFF232323);
  static const Color secondary800 = Color(0xFF1D2939);
  static const Color secondary350 = Color(0xFF868E96);
  static const Color secondary300 = Color(0xFF69757D);
  static const Color secondary250 = Color(0xFF667085);
  static const Color secondary200 = Color(0xFFCCD1D9);
  static const Color secondary100 = Color(0xFFE0E3E8);

  static const Color border500 = Color(0xFFD0D5DD);
  static const Color border450 = Color(0xFFC1C7D1);
  static const Color border400 = Color(0xFF98A2B3);
  static const Color border300 = Color(0xFFEAECF0);
  static const Color border200 = Color(0xFFCCDDF1);

  static const Color shadow = Color.fromARGB(6, 9, 42, 66);
  static const Color shadow2 = Color.fromRGBO(218, 221, 232, 0.5);
  static const Color cardShadow = Color(0xFF989899);

  static const Color white950 = Color(0xFFFCFCFD);

  static const Color textHighlight = Color(0xFF1967FD);

  static const BoxShadow boxShadow = BoxShadow(
    color: shadow,
    blurRadius: 24,
    spreadRadius: 0,
    offset: Offset(0, 2),
  );

  static const BoxShadow boxShadow300 = BoxShadow(
    color: Color.fromARGB(8, 152, 152, 153),
    blurRadius: 10,
    spreadRadius: 0,
    offset: Offset(0, 2),
  );

  static const BoxShadow boxShadow600 = BoxShadow(
    color: Color.fromARGB(26, 0, 0, 0),
    blurRadius: 10,
    spreadRadius: 0,
    offset: Offset(0, 2),
  );
}
