import 'package:edu_advisor/core/services/secure_storage_keys.dart';
import 'package:edu_advisor/core/services/secure_storage_service.dart';

class TokenStorageService {
  TokenStorageService({SecureStorageService? secureStorageService})
    : _secureStorageService = secureStorageService ?? SecureStorageService();

  final SecureStorageService _secureStorageService;

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String accessTokenExpiresAt,
    required String refreshTokenExpiresAt,
  }) async {
    await _secureStorageService.write(
      key: SecureStorageKeys.accessToken,
      value: accessToken,
    );
    await _secureStorageService.write(
      key: SecureStorageKeys.refreshToken,
      value: refreshToken,
    );
    await _secureStorageService.write(
      key: SecureStorageKeys.accessTokenExpiresAt,
      value: accessTokenExpiresAt,
    );
    await _secureStorageService.write(
      key: SecureStorageKeys.refreshTokenExpiresAt,
      value: refreshTokenExpiresAt,
    );
  }

  Future<String?> getAccessToken() {
    return _secureStorageService.read(key: SecureStorageKeys.accessToken);
  }

  Future<String?> getRefreshToken() {
    return _secureStorageService.read(key: SecureStorageKeys.refreshToken);
  }

  Future<String?> getAccessTokenExpiresAt() {
    return _secureStorageService.read(
      key: SecureStorageKeys.accessTokenExpiresAt,
    );
  }

  Future<String?> getRefreshTokenExpiresAt() {
    return _secureStorageService.read(
      key: SecureStorageKeys.refreshTokenExpiresAt,
    );
  }

  Future<void> clearTokens() async {
    await _secureStorageService.delete(key: SecureStorageKeys.accessToken);
    await _secureStorageService.delete(key: SecureStorageKeys.refreshToken);
    await _secureStorageService.delete(
      key: SecureStorageKeys.accessTokenExpiresAt,
    );
    await _secureStorageService.delete(
      key: SecureStorageKeys.refreshTokenExpiresAt,
    );
  }
}
