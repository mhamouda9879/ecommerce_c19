abstract class ProfileRemoteDataSource {
  Future<void> updateProfile({String? name, String? email, String? phone});

  // Returns the new token; the old one stops working.
  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
