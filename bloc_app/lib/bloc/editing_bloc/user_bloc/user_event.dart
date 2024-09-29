import 'package:bloc_app/models/user_data_model.dart';

abstract class UserEvent {}

class UserProfileEvent extends UserEvent {}

class UserOrderEvent extends UserEvent {}

class UserAddressEvent extends UserEvent {}

class UserPayment extends UserEvent {
  final UserDataModel user;

  UserPayment({required this.user});
}

class UserEditingProfileEvent extends UserEvent {
  final UserDataModel user;
  final String firstName;
  final String maidenName;
  final String gender;
  final int age;
  final String phone;
  final String email;

  UserEditingProfileEvent({
    required this.user,
    required this.firstName,
    required this.maidenName,
    required this.gender,
    required this.age,
    required this.phone,
    required this.email,
  });
}
