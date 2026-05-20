import '../../../../core/storage/secure_storage.dart';

class ProfileRepository {
  final SecureStorage secureStorage;
  ProfileRepository(this.secureStorage);

  Future<void> logout() async {
    await secureStorage.clearAll(); // Token delete
  }
}