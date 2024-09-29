import 'package:bloc_app/models/user_data_model.dart';

abstract class AuthState {}

class AuthLoginInitialState extends AuthState {}

class AuthLoginLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {
  final UserDataModel user;

  AuthLoginSuccessState({required this.user});
}

class AuthAdminLoginSuccessState extends AuthState {
  final UserDataModel user;

  AuthAdminLoginSuccessState({required this.user});
}

class AuthLoginErrorState extends AuthState {
  final String error;

  AuthLoginErrorState({required this.error});
}

class AuthRegisterInitialState extends AuthState {}

class AuthRegisterLoadingState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {}

class AuthRegisterErrorState extends AuthState {
  final String error;

  AuthRegisterErrorState({required this.error});
}

class AuthRegisterErrorUserNameState extends AuthState {
  final String error;

  AuthRegisterErrorUserNameState({required this.error});
}

class AuthRegisterPasswordErrorState extends AuthState {}

class AuthRegisterErrorPasswordAgainState extends AuthState {
  final String error;

  AuthRegisterErrorPasswordAgainState({required this.error});
}
