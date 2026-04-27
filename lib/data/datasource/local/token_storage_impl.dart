// use flutter_secure_storage package


import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/repositories/token_storage.dart';

class TokenStorageImpl implements TokenStorage {
  final FlutterSecureStorage _storage;

  static const _accessKey = 'ACCESS_TOKEN';
  static const _refreshKey = 'REFRESH_TOKEN';

  TokenStorageImpl(this._storage);

  @override
  Future<String?> getAccessToken() =>
      _storage.read(key: _accessKey);

  @override
  Future<String?> getRefreshToken() =>
      _storage.read(key: _refreshKey);

  @override
  Future<void> saveTokens(
      String accessToken,
      String refreshToken,
      ) async {
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}

