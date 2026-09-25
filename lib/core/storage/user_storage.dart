import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

typedef StoredUser = ({String? name, String? email, String? phone});

@lazySingleton
class UserStorage {
  UserStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const _nameKey = 'user_name';
  static const _emailKey = 'user_email';
  static const _phoneKey = 'user_phone';

  Future<void> saveUser({String? name, String? email, String? phone}) async {
    if (name != null) await _storage.write(key: _nameKey, value: name);
    if (email != null) await _storage.write(key: _emailKey, value: email);
    if (phone != null) await _storage.write(key: _phoneKey, value: phone);
  }

  Future<StoredUser> getUser() async => (
    name: await _storage.read(key: _nameKey),
    email: await _storage.read(key: _emailKey),
    phone: await _storage.read(key: _phoneKey),
  );

  Future<void> deleteUser() async {
    await _storage.delete(key: _nameKey);
    await _storage.delete(key: _emailKey);
    await _storage.delete(key: _phoneKey);
  }
}
