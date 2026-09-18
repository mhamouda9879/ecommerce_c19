abstract class AuthEvent {}

class SignUpWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

  SignUpWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });
}
