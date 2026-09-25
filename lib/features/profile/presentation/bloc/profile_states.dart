import 'package:ecommerce_c19/core/utils/request_status.dart';
import 'package:ecommerce_c19/features/profile/domain/entities/user_entity.dart';

export 'package:ecommerce_c19/core/utils/request_status.dart';

class ProfileState {
  final UserEntity? user;
  final String? errorMessage;
  final RequestStatus updateProfileRequestStatus;
  final RequestStatus changePasswordRequestStatus;

  const ProfileState({
    this.user,
    this.errorMessage,
    this.updateProfileRequestStatus = RequestStatus.init,
    this.changePasswordRequestStatus = RequestStatus.init,
  });

  ProfileState copyWith({
    UserEntity? user,
    String? errorMessage,
    RequestStatus? updateProfileRequestStatus,
    RequestStatus? changePasswordRequestStatus,
  }) {
    return ProfileState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      updateProfileRequestStatus:
          updateProfileRequestStatus ?? this.updateProfileRequestStatus,
      changePasswordRequestStatus:
          changePasswordRequestStatus ?? this.changePasswordRequestStatus,
    );
  }
}
