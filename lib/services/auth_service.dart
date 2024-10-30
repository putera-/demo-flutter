import 'dart:convert';

import 'package:pgnpartner_mobile/data/models/auth/auth_user.dart';
import 'package:pgnpartner_mobile/data/models/location/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _sessionKey = 'session_key';
  static const String _biometricUsername = 'biometric_username';
  static const String _biometricPassword = 'biometric_password';
  static const String _biometricStatus = 'biometric_status';
  static const String _hasShownBiometricPopup = 'has_shown_biometric_popup';
  static const String _user = 'user';
  static const String _kabupatens = 'kabupatens';

  // SESSION KEY
  Future<void> saveSessionKey(String sessionKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, sessionKey);
  }

  Future<String?> getSessionKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sessionKey);
  }

  Future<void> removeSessionKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }

  // BIOMETRIC USERNAME
  Future<void> saveBiometricUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_biometricUsername, username);
  }

  Future<String?> getBiometricUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_biometricUsername);
  }

  Future<void> removeBiometricUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_biometricUsername);
  }

  // BIOMETRIC PASSWORD
  Future<void> saveBiometricPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_biometricPassword, password);
  }

  Future<String?> getBiometricPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_biometricPassword);
  }

  Future<void> removeBiometricPassword() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_biometricPassword);
  }

  // BIOMETRIC STATUS
  Future<bool> getBiometricStatus() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final dynamic status = sharedPreferences.get(_biometricStatus);
    if (status is bool) {
      return status;
    } else {
      await sharedPreferences.setBool(_biometricStatus, false);
      return false;
    }
  }

  Future<void> activateBiometric() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricStatus, true);
  }

  Future<void> deActivateBiometric() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricStatus, false);
  }

  // BIOMETRIC OFFERING
  Future<bool> getHasShownBiometricPopup() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final status = sharedPreferences.getBool(_hasShownBiometricPopup) ?? false;
    return status;
  }

  Future<void> setHasShownBiometricPopup(bool hasShown) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasShownBiometricPopup, hasShown);
  }

  // USER DATA
  Future<void> saveUser(String userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_user, userData);
  }

  Future<AuthUser?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString(_user);
    if (userData != null) {
      Map<String, dynamic> userMap = jsonDecode(userData);
      return AuthUser.fromJson(userMap);
    }
    return null;
  }

  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_user);
  }

  // LOCATIONS
  Future<void> saveKabupatens(List<KabupatenModel> kabupatenKotaList) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonKabupaten = jsonEncode(kabupatenKotaList.map((e) => e.toJson()).toList());
    await prefs.setString(_kabupatens, jsonKabupaten);
  }

  Future<List<KabupatenModel>> getKabupatens() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonKabupaten = prefs.getString(_kabupatens);

    return jsonKabupaten != null
        ? List<KabupatenModel>.from(jsonDecode(jsonKabupaten).map((x) => KabupatenModel.fromJson(x)))
        : [];
  }

  Future<void> removeKabupatens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kabupatens);
  }
}
