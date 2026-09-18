import 'package:ecommerce_c19/features/auth/domain/use_cases/signUp_usecase.dart';
import 'package:ecommerce_c19/features/auth/domain/use_cases/sign_in_usecase.dart';
import 'package:ecommerce_c19/features/auth/presentation/bloc/auth_events.dart';
import 'package:ecommerce_c19/features/auth/presentation/bloc/auth_states.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SignUpUseCase signUpUseCase;
  SignInUseCase signInUseCase;
  AuthBloc(this.signUpUseCase, this.signInUseCase) : super(AuthInitial()) {
    on<SignUpWithEmailAndPasswordEvent>((event, emit) async {
      emit(state.copyWith(signUpRequestStatus: RequestStatus.loading));

      final result = await signUpUseCase(
        email: event.email,
        password: event.password,
        name: event.name,
        phone: event.phone,
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            signUpRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(
            signUpRequestStatus: RequestStatus.success,
            authResponse: response,
          ),
        ),
      );
    });

    on<SignInWithEmailAndPasswordEvent>((event, emit) async {
      emit(state.copyWith(signInRequestStatus: RequestStatus.loading));

      final result = await signInUseCase(
        email: event.email,
        password: event.password,
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            signInRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(
            signInRequestStatus: RequestStatus.success,
            authResponse: response,
          ),
        ),
      );
    });
  }
}
