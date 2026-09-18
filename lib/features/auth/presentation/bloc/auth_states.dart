import 'package:ecommerce_c19/core/utils/request_status.dart';
import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';

export 'package:ecommerce_c19/core/utils/request_status.dart';

class AuthState {
  AuthResponse? authResponse;
  String? errorMessage;
  RequestStatus? signUpRequestStatus;
  RequestStatus? signInRequestStatus;

  AuthState({
    this.authResponse,
    this.errorMessage,
    this.signUpRequestStatus = RequestStatus.init,
    this.signInRequestStatus = RequestStatus.init,
  });

  AuthState copyWith({
    AuthResponse? authResponse,
    String? errorMessage,
    RequestStatus? signUpRequestStatus,
    RequestStatus? signInRequestStatus,
  }) {
    return AuthState(
      authResponse: authResponse ?? this.authResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      signUpRequestStatus: signUpRequestStatus ?? this.signUpRequestStatus,
      signInRequestStatus: signInRequestStatus ?? this.signInRequestStatus,
    );
  }
}

class AuthInitial extends AuthState {
  AuthInitial() : super();
}
