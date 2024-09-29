import 'package:bloc_app/models/user_data_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  final UserDataModel user;

  const UserState({required this.user});
  @override
  List<Object> get props => [user];
}

abstract class UserProfile extends UserState {
  const UserProfile({required super.user});
}

class UserProfileInitialState extends UserProfile {
  const UserProfileInitialState({required super.user});
}

class UserEditingInitalState extends UserProfile {
  const UserEditingInitalState({required super.user});
}

class UserEditingLoadingState extends UserProfile {
  const UserEditingLoadingState({required super.user});
}

class UserEditingSuccessState extends UserProfile {
  const UserEditingSuccessState({required super.user});
}

class UserEditingErrorState extends UserProfile {
  const UserEditingErrorState({required super.user});
}
