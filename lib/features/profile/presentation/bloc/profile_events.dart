abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

// Only the fields that changed: the API rejects an unchanged email as taken.
class UpdateProfileEvent extends ProfileEvent {
  final String? name;
  final String? email;
  final String? phone;

  UpdateProfileEvent({this.name, this.email, this.phone});
}

class ChangePasswordEvent extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
  });
}
