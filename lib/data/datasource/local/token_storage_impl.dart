// use flutter_secure_storage package
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/repositories/token_storage.dart';

class TokenStorageImpl implements TokenStorage {
  final FlutterSecureStorage _storage;

  static const _accessKey = 'ACCESS_TOKEN';
  static const _refreshKey = 'REFRESH_TOKEN';
  static const _introKey = 'INTRO_SEEN';
  static const _nameKey = 'NAME';

  TokenStorageImpl(this._storage);

  @override
  Future<String?> getAccessToken() => _storage.read(key: _accessKey);

  @override
  Future<String?> getRefreshToken() => _storage.read(key: _refreshKey);

  @override
  Future<void> saveTokens(
      String accessToken,
      String refreshToken,
      ) async {
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }

  @override
  Future<void> saveName(String name) async {
    await _storage.write(
      key: _nameKey,
      value: name,
    );
  }

  @override
  Future<String?> getName() async {
    return await _storage.read(
      key: _nameKey,
    );
  }

  @override
  Future<void> clearName() async {
    await _storage.delete(
      key: _nameKey,
    );
  }

  Future<bool> isIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_introKey) ?? false;
  }

  Future<void> setIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_introKey, true);
  }

  @override
  Future<void> clear() async {

    await _storage.deleteAll();

    final prefs = await SharedPreferences.getInstance();

    // await prefs.clear();
  }
}

