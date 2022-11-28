import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._internal();  // private constructor
  static final SecureStorage instance = SecureStorage._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  //final _iOptions = const IOSOptions(accessibility: IOSAccessibility.first_unlock);
  final _aOptions = const AndroidOptions(encryptedSharedPreferences: true);

  Future<void> set(String key, String value) async {
    await _storage.write(key: key, value: value,/* iOptions: _iOptions,*/ aOptions: _aOptions);
  }

  Future<String?> get(String key) async {
    return await _storage.read(key: key,  aOptions: _aOptions);
  }

}