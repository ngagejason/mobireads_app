import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();
  static const _currentUserIdKey = '_currentUserIdKey';
  static const _bearerTokenKey = '_bearerTokenKey';

  static Future clearAll() async =>
      await _storage.deleteAll();

  static Future setCurrentUserId(String id) async {
    await _storage.write(key: _currentUserIdKey, value: id);
  }

  static Future<String?> getCurrentUserId() async {
    return await _storage.read(key: _currentUserIdKey);
  }

  static Future setBearerToken(String id) async {
    await _storage.write(key: _bearerTokenKey, value: id);
  }

  static Future<String?> getBearerToken() async {
    return await _storage.read(key: _bearerTokenKey);
  }
}