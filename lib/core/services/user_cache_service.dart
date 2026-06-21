import 'dart:convert';

import 'package:edu_advisor/core/services/secure_storage_keys.dart';
import 'package:edu_advisor/core/services/secure_storage_service.dart';

class UserCacheService {
  UserCacheService({SecureStorageService? secureStorageService})
    : _secureStorageService = secureStorageService ?? SecureStorageService();

  final SecureStorageService _secureStorageService;

  Future<void> saveCurrentUser(Map<String, dynamic> userJson) async {
    await _secureStorageService.write(
      key: SecureStorageKeys.currentUser,
      value: jsonEncode(userJson),
    );
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final cachedUser = await _secureStorageService.read(
      key: SecureStorageKeys.currentUser,
    );

    if (cachedUser == null || cachedUser.isEmpty) {
      return null;
    }

    final decodedUser = jsonDecode(cachedUser);
    if (decodedUser is! Map) {
      await clearCurrentUser();
      return null;
    }

    return Map<String, dynamic>.from(decodedUser);
  }

  Future<void> clearCurrentUser() async {
    await _secureStorageService.delete(key: SecureStorageKeys.currentUser);
  }
}
