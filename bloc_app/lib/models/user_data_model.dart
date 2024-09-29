import 'dart:convert';

import 'package:bloc_app/models/role_model.dart';

class UserDataModel {
  final String? firstName;
  final String maidenName;
  final int age;
  final String phone;
  final String username;
  final String password;
  final String image;
  final String email;
  final String gender;
  final int id;
  final List<RoleModel> roles;
  UserDataModel(
      {required this.firstName,
      required this.maidenName,
      required this.age,
      required this.phone,
      required this.username,
      required this.password,
      required this.image,
      required this.email,
      required this.gender,
      required this.id,
      required this.roles});

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    var roleList = map['roles'] as List;
    List<RoleModel> rolesList =
        roleList.map((role) => RoleModel.fromMap(role)).toList();
    return UserDataModel(
        firstName: map['firstName'] ?? "",
        maidenName: map['maidenName'] ?? "",
        age: map['age'] ?? 0,
        phone: map['phone'] ?? "",
        username: map['username'] ?? "",
        password: map['password'] ?? "",
        image: map['image'] ?? "",
        email: map['email'] ?? "",
        gender: map['gender'] ?? '',
        id: map['id'] ?? 0,
        roles: rolesList);
  }
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'maidenName': maidenName,
      'age': age,
      'phone': phone,
      'username': username,
      'password': password,
      'image': image,
      'email': email,
      'gender': gender
    };
  }

  String toJson() => jsonEncode(toMap());
  factory UserDataModel.fromJson(String source) {
    return UserDataModel.fromMap(json.decode(source));
  }
}
