abstract class PasswordEditingEvent {}

class PasswordEditing extends PasswordEditingEvent {
  final String currentPassword;
  final String newPassword;
  final String againNewPassword;
  final int id;

  PasswordEditing(
      {required this.currentPassword,
      required this.newPassword,
      required this.againNewPassword,
      required this.id});
}
