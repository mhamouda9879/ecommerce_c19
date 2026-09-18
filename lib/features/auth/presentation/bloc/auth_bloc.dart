import 'package:ecommerce_c19/features/auth/domain/use_cases/signUp_usecase.dart';
import 'package:ecommerce_c19/features/auth/presentation/bloc/auth_events.dart';
import 'package:ecommerce_c19/features/auth/presentation/bloc/auth_states.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SignUpUseCase signUpUseCase;
  AuthBloc(this.signUpUseCase) : super(AuthInitial()) {
    on<SignUpWithEmailAndPasswordEvent>((event, emit) async {
      emit(state.copyWith(signUpRequestStatus: RequestStatus.loading));

      try {
        var result = await signUpUseCase(
          email: event.email,
          password: event.password,
          name: event.name,
          phone: event.phone,
        );
        emit(
          state.copyWith(
            signUpRequestStatus: RequestStatus.success,
            authResponse: result,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            signUpRequestStatus: RequestStatus.error,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
