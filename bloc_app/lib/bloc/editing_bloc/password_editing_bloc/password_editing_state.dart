abstract class PasswordEditingState {}

class PasswordEditingInitialState extends PasswordEditingState {}

class PasswordEditingSuccessState extends PasswordEditingState {}

class PasswordEditingErrorState extends PasswordEditingState {
  final String error;

  PasswordEditingErrorState({required this.error});
}

class PasswordEditingLoadingState extends PasswordEditingState {}
