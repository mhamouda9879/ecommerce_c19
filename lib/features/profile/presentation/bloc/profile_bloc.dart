import 'package:bloc/bloc.dart';
import 'package:ecommerce_c19/features/profile/domain/use_cases/change_password_usecase.dart';
import 'package:ecommerce_c19/features/profile/domain/use_cases/get_profile_usecase.dart';
import 'package:ecommerce_c19/features/profile/domain/use_cases/update_profile_usecase.dart';
import 'package:ecommerce_c19/features/profile/presentation/bloc/profile_events.dart';
import 'package:ecommerce_c19/features/profile/presentation/bloc/profile_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileBloc(
    this.getProfileUseCase,
    this.updateProfileUseCase,
    this.changePasswordUseCase,
  ) : super(const ProfileState()) {
    on<GetProfileEvent>((event, emit) async {
      emit(state.copyWith(user: await getProfileUseCase()));
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(state.copyWith(updateProfileRequestStatus: RequestStatus.loading));

      final result = await updateProfileUseCase(
        name: event.name,
        email: event.email,
        phone: event.phone,
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            updateProfileRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (user) => emit(
          state.copyWith(
            updateProfileRequestStatus: RequestStatus.success,
            user: user,
          ),
        ),
      );
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(state.copyWith(changePasswordRequestStatus: RequestStatus.loading));

      final result = await changePasswordUseCase(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            changePasswordRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (_) => emit(
          state.copyWith(changePasswordRequestStatus: RequestStatus.success),
        ),
      );
    });
  }
}
