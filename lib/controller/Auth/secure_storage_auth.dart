import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> storeCondition(String condition) async {
    await _storage.write(key: 'condition', value: condition);
  }

  Future<String?> getCondition() async {
    return await _storage.read(key: 'condition');
  }

  Future<void> deleteCondition() async {
    await _storage.delete(key: 'condition');
  }
}
