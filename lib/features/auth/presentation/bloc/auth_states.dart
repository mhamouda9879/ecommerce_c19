import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';

enum RequestStatus { init, loading, success, error }

class AuthState {
  AuthResponse? authResponse;
  String? errorMessage;
  RequestStatus? signUpRequestStatus;

  AuthState({
    this.authResponse,
    this.errorMessage,
    this.signUpRequestStatus = RequestStatus.init,
  });

  AuthState copyWith({
    AuthResponse? authResponse,
    String? errorMessage,
    RequestStatus? signUpRequestStatus,
  }) {
    return AuthState(
      authResponse: authResponse ?? this.authResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      signUpRequestStatus: signUpRequestStatus ?? this.signUpRequestStatus,
    );
  }
}

class AuthInitial extends AuthState {
  AuthInitial() : super();
}
