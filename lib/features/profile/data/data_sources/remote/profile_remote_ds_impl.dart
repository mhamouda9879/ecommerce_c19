import 'package:ecommerce_c19/core/network/api_constants.dart';
import 'package:ecommerce_c19/core/network/dio_helper.dart';
import 'package:ecommerce_c19/core/storage/token_storage.dart';
import 'package:ecommerce_c19/features/profile/data/data_sources/remote/profile_remote_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDsImpl implements ProfileRemoteDataSource {
  final DioHelper dioHelper;
  final TokenStorage tokenStorage;

  ProfileRemoteDsImpl({required this.dioHelper, required this.tokenStorage});

  @override
  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
  }) async {
    await dioHelper.put(
      ApiConstants.updateMe,
      data: {'name': ?name, 'email': ?email, 'phone': ?phone},
      token: await tokenStorage.getToken(),
    );
  }

  @override
  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final result = await dioHelper.put(
      ApiConstants.changeMyPassword,
      data: {
        'currentPassword': currentPassword,
        'password': newPassword,
        'rePassword': newPassword,
      },
      token: await tokenStorage.getToken(),
    );
    return result.data['token'] as String;
  }
}
