abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String userName;
  final String password;

  AuthLoginEvent({required this.userName, required this.password});
}

class AuthLoginCallbackEvent extends AuthEvent {}

class AuthRegisterCallbackEvent extends AuthEvent {}

class AuthRegisterEvent extends AuthEvent {}

class AuthRegisterPasswordErrorEvent extends AuthEvent {}

class AuthSendRegisterEvent extends AuthEvent {
  final String name;
  final String username;
  final String password;
  final String passwordAgain;

  AuthSendRegisterEvent(
      {required this.name,
      required this.username,
      required this.password,
      required this.passwordAgain});
}
