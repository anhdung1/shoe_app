import 'dart:async';
import 'dart:convert';

import 'package:bloc_app/bloc/editing_bloc/user_bloc/user_event.dart';
import 'package:bloc_app/bloc/editing_bloc/user_bloc/user_state.dart';
import 'package:bloc_app/ip_v4.dart';
import 'package:bloc_app/models/user_data_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(super.initialState) {
    on<UserProfileEvent>(userInitialFetch);
    on<UserEditingProfileEvent>(userEditing);
  }

  FutureOr<void> userInitialFetch(
      UserProfileEvent event, Emitter<UserState> emit) async {}

  FutureOr<void> userEditing(
      UserEditingProfileEvent event, Emitter<UserState> emit) async {
    emit(UserEditingLoadingState(user: event.user));
    var client = http.Client();

    try {
      Map<String, dynamic> editUser = {
        'firstName': event.firstName,
        'maidenName': event.maidenName,
        'email': event.email,
        'age': event.age,
        'phone': event.phone,
        'gender': event.gender
      };

      var response = await client.put(
          Uri.parse('http://$ip:8080/users/edit/${event.user.id}'),
          body: jsonEncode(editUser),
          headers: <String, String>{'Content-Type': 'application/json'});
      var result = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        UserDataModel user =
            UserDataModel.fromMap(result as Map<String, dynamic>);

        emit(UserEditingSuccessState(user: user));
      } else {
        emit(UserEditingInitalState(user: event.user));
      }
    } catch (e) {
      debugPrint('Caught error: $e');
    }
  }
}
